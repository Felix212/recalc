/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareUser;
import com.lsgskychefs.cbase.middleware.base.business.CbaseRole;
import com.lsgskychefs.cbase.middleware.base.business.SapOdataLogin;
import com.lsgskychefs.cbase.middleware.base.configuration.security.CbaseMiddlewareSecurityConfiguration;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareUserLoginException;
import com.lsgskychefs.cbase.middleware.base.error.exception.LoginStatus;
import com.lsgskychefs.cbase.middleware.common.persistence.CommonRepository;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseLoginHistKind;
import com.lsgskychefs.cbase.middleware.persistence.constant.common.PasswordRule;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginHistKind;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginHistory;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginNegativ;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysRoles;
import com.lsgskychefs.cbase.middleware.persistence.general.SysLoginHistoryRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysLoginNegativeRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysLoginRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysRolesRepository;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * Service to load the user by username for the (Basic Authentication, Passwordcheck).
 *
 * @author Ingo Rietzschel - U125742
 * @author Dirk Bunk - U200035
 * @see CbaseMiddlewareSecurityConfiguration
 */
@Service
public class CbaseMiddlewareUserDetailService extends AbstractCbaseMiddlewareService implements UserDetailsService {

	/** Max length of {@link SysLoginHistory#setCversion(String)} */
	private static final int MAX_LENGTH_VERSION_NUMBER_FIELD = 20;

	/** RC4 - cryption name */
	private static final String RC4 = "RC4";

	/** MD5 hash algorithm */
	private static final String MD5 = "MD5";

	/** password key with which the password are encrypted */
	private static final String CRYPTO_KEY = "LSYcbaseCrypto2008";

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareUserDetailService.class);

	/** application name and version as a max 20 char string */
	private String applicationNameAndVersion;

	/** Repository for {@link SysLogin} entity. */
	@Autowired
	private SysLoginRepository sysLoginRepo;

	/** Repository for {@link SysRoles} entity */
	@Autowired
	private SysRolesRepository sysRolesRepo;

	/** Repository for {@link SysLoginNegativ} entity */
	@Autowired
	private SysLoginNegativeRepository sysloginNegativeRepository;

	/** Repository for {@link SysLoginHistory} entity */
	@Autowired
	private SysLoginHistoryRepository sysLoginHistoryRepository;

	/** {@link SapOdataHelper} service */
	@Autowired
	private SapOdataHelper sapOdataHelper;

	/** Common repository class */
	@Autowired
	private CommonRepository commonRepository;

	/** init applicationNameAndVersion */
	@PostConstruct
	private void init() {
		applicationNameAndVersion = "CM" + "-" + configService.getVersion();
		if (applicationNameAndVersion.length() > CbaseMiddlewareUserDetailService.MAX_LENGTH_VERSION_NUMBER_FIELD) {
			applicationNameAndVersion =
					applicationNameAndVersion.substring(0, CbaseMiddlewareUserDetailService.MAX_LENGTH_VERSION_NUMBER_FIELD);
		}

	}

	/**
	 * Load user from db and check the {@link LoginStatus#DISALLOW_WEB_LOGIN} role. <br>
	 * {@inheritDoc}
	 * <p>
	 * throws RuntimeException of type <code>CbaseMiddlewareUserLoginException</code> if the user couldn't load
	 * <ul>
	 * <li>LoginStatus#USER_PASSWORD_UNKNOWN
	 * <li>LoginStatus#DISALLOW_WEB_LOGIN
	 * </ul>
	 */
	@Transactional(noRollbackFor = CbaseMiddlewareUserLoginException.class)
	@Override
	public CbaseMiddlewareUser loadUserByUsername(final String username) {

		final SysLogin sysLogin = sysLoginRepo.findByCusername(username);
		if (sysLogin == null) {
			throw new CbaseMiddlewareUserLoginException(LoginStatus.USER_PASSWORD_UNKNOWN, "Username '" + username + "' not found");
		}

		final Set<GrantedAuthority> grantedAuthorities = getGrantedAuthorities(sysLogin);

		for (final GrantedAuthority grantedAuthority : grantedAuthorities) {
			if (grantedAuthority.getAuthority().equals(CbaseRole.DISALLOW_WEB_LOGIN.getRoleName())) {
				throw new CbaseMiddlewareUserLoginException(LoginStatus.DISALLOW_WEB_LOGIN);
			}
		}

		encrypteDatabasePasswordIfNecessary(sysLogin);

		final HttpServletRequest request = getRequest();
		return new CbaseMiddlewareUser(grantedAuthorities, sysLogin, sysLogin.getCuserPwd(), null,
				request.getHeader(HttpHeaders.USER_AGENT), request.getRemoteAddr(), request.getRemoteHost());
	}

	/**
	 * Get the {@link GrantedAuthority} list.
	 *
	 * @param sysLogin the user
	 * @return the granted authorities
	 */
	private Set<GrantedAuthority> getGrantedAuthorities(final SysLogin sysLogin) {
		final Set<GrantedAuthority> authorities = new HashSet<>();
		authorities.add(new SimpleGrantedAuthority(CbaseRole.roleWithPrefix(CbaseRole.ROLE_PWD_NOT_EXPIRED)));

		final Set<SysRoles> roles = new HashSet<>();
		roles.addAll(sysRolesRepo.findDirectRoleByUser(sysLogin));
		roles.addAll(sysRolesRepo.findGroupRoleByUser(sysLogin));

		for (final SysRoles role : roles) {
			final String roleName = role.getCroleName().replace(" ", "_").toUpperCase();
			authorities.add(new SimpleGrantedAuthority(CbaseRole.roleWithPrefix(roleName)));
			authorities.add(new SimpleGrantedAuthority(CbaseRole.roleWithPrefix(Integer.toString(role.getNroleId()))));
			CbaseMiddlewareUserDetailService.LOGGER.debug("User {} Role: {} - {} ", sysLogin.getCusername(), roleName, role.getCroleName());
		}

		return authorities;
	}

	/**
	 * Check if the password is okay.
	 * <ul>
	 * Check:
	 * <li>not in negative list
	 * <li>Today change not to often
	 * <li>password is really new, not used in past
	 * </ul>
	 * 
	 * @param password the password to check
	 * @param sysLogin the current user ({@link SysLogin})
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#NOT_FOUND} if the given user was not found
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#WRONG_PWD} if the current password is wrong
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} if the password is on negative list
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#MAX_CHANGES} - Today the password has been changed too often
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#PWD_ALREADY_USED} - The password has already been used (as inital
	 *             password)
	 *             </ul>
	 */
	private void doPasswordChecks(final SysLogin sysLogin, final String password)
			throws CbaseMiddlewareBusinessException {
		// Check if the user exists
		if (sysLogin == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.NOT_FOUND,
					"The given username was not found!");
		}

		// check max changes per day
		final Date start = DateUtils.truncate(new Date(), Calendar.DAY_OF_MONTH);
		final Date end = DateUtils.addDays(start, 1);
		final List<SysLoginHistory> sysLoginHistories = sysLoginHistoryRepository.findSysLoginHistory(sysLogin.getNuserId(), start, end);
		if (sysLoginHistories.size() >= getPasswortRuleValueAsInteger(PasswordRule.MAX_CHANGES_PER_DAY)) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.MAX_CHANGES,
					"Today the password has been changed too often!");
		}

		if (password.equals("..--..")) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"New password is wrong(is in negative list) ");
		}

		// check against negative list
		if (sysloginNegativeRepository.findByCpasswordIgnoreCase(password) != null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"New password is wrong(is in negative list) ");
		}

		// check if the password is used before as initial password
		if (sysLogin.getCpwdInit().equals(password)) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.PWD_ALREADY_USED,
					"The password has already been used as inital password!");
		}

		final String encryptPwd = encryptDecrypt(password, true, sysLogin.getCusername());

		// check password against in the past used passwords
		final Integer maxResult = getPasswortRuleValueAsInteger(PasswordRule.PASSWORD_HISTORY);
		final List<SysLoginHistory> pwdChanges = commonRepository.findLastPwdChanges(sysLogin, maxResult);
		for (final SysLoginHistory sysLoginHistory : pwdChanges) {
			if (encryptPwd.equals(sysLoginHistory.getCuserPwd())) {
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.PWD_ALREADY_USED,
						"The password has already been used!");
			}
		}
	}

	/**
	 * Check the password and set if it is ok.
	 * <ul>
	 * Check:
	 * <li>not in negative list
	 * <li>Today change not to often
	 * <li>password is really new, not used in past
	 * </ul>
	 *
	 * @param username the user to set the password for
	 * @param password the new password to set
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#NOT_FOUND} if the given username was not found
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#WRONG_PWD} if the current password is wrong
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} if the password is on negative list
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#MAX_CHANGES} - Today the password has been changed too often
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#PWD_ALREADY_USED} - The password has already been used (as inital
	 *             password)
	 *             </ul>
	 */
	public void userChangePassword(final String username, final String password)
			throws CbaseMiddlewareBusinessException {
		final SysLogin sysLogin = sysLoginRepo.findByCusername(username);
		final String encryptPwd = encryptDecrypt(password, true, sysLogin.getCusername());

		// do password checks
		doPasswordChecks(sysLogin, password);

		// change password to new password
		sysLogin.setCuserPwd(encryptPwd);
		commonRepository.changeDbUserPwd(username, password);
		final Date date = now();
		sysLogin.setDpwdDate(date);
		// legacy code is removed in future, if all applications use the dpwdDate
		sysLogin.setCpwdDate(DateFormatUtils.format(date, FormatConstants.DATE));
		// legacy code is removed in future, if all applications use the encrypted and base64 encoded cuserPwd
		sysLogin.setCuserpassword(password);
		sysLogin.setNpwdIsInit(0);
		addPwdProtocol(sysLogin, CbaseLoginHistKind.PASSWORD_CHANGED, encryptPwd);

		// also unlock the user
		userUnlock(username);
	}

	/**
	 * Check the password and reset if it is ok.
	 * <ul>
	 * Check:
	 * <li>not in negative list
	 * <li>Today change not to often
	 * <li>password is really new, not used in past
	 * </ul>
	 *
	 * @param username the user to set the password for
	 * @param password the new password to reset
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#NOT_FOUND} if the given username was not found
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#WRONG_PWD} if the current password is wrong
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} if the password is on negative list
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#MAX_CHANGES} - Today the password has been changed too often
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#PWD_ALREADY_USED} - The password has already been used (as inital
	 *             password)
	 *             </ul>
	 */
	public void userResetPassword(final String username, final String password)
			throws CbaseMiddlewareBusinessException {
		final SysLogin sysLogin = sysLoginRepo.findByCusername(username);
		final String encryptPwd = encryptDecrypt(password, true, sysLogin.getCusername());

		// do password checks
		doPasswordChecks(sysLogin, password);

		// change initial password to new password
		sysLogin.setCpwdInit(password);
		// change the user's current password to new password
		sysLogin.setCuserPwd(encryptPwd);
		commonRepository.changeDbUserPwd(username, password);
		final Date date = now();
		sysLogin.setDpwdDate(date);
		// legacy code is removed in future, if all applications use the dpwdDate
		sysLogin.setCpwdDate(DateFormatUtils.format(date, FormatConstants.DATE));
		// legacy code is removed in future, if all applications use the encrypted and base64 encoded cuserPwd
		sysLogin.setCuserpassword(password);
		sysLogin.setNpwdIsInit(1);
		addPwdProtocol(sysLogin, CbaseLoginHistKind.PASSWORD_RESET, encryptPwd);

		// also unlock the user
		userUnlock(username);
	}

	/**
	 * Check the new password and set if it is ok.
	 * <ul>
	 * Check:
	 * <li>not in negative list
	 * <li>Today change not to often
	 * <li>password is really new, not used in past
	 * </ul>
	 *
	 * @param password current user password to check
	 * @param newPassword the new password to set
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#NOT_FOUND} if the given username was not found
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#WRONG_PWD} if the current password is wrong
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} if the password is on negative list
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#MAX_CHANGES} - Today the password has been changed too often
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#PWD_ALREADY_USED} - The password has already been used (as inital
	 *             password)
	 *             </ul>
	 */
	public void changePassword(final String password, final String newPassword) throws CbaseMiddlewareBusinessException {
		final String username = getLoginUser().getUsername();
		final SysLogin sysLogin = sysLoginRepo.findByCusername(username);
		final String encryptReqPwd = encryptDecrypt(password, true, username);
		try {
			checkPassword(sysLogin, encryptReqPwd);
		} catch (final CbaseMiddlewareUserLoginException e) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.WRONG_PWD, "Wrong current password!", e);
		}

		userChangePassword(username, newPassword);
	}

	/**
	 * Unlocks a user. Resetting also the failed login and grace login count.
	 * 
	 * @param username the user to be unlocked
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#NOT_FOUND} if the given username was not found
	 *             </ul>
	 */
	public void userUnlock(final String username) throws CbaseMiddlewareBusinessException {
		final SysLogin sysLogin = sysLoginRepo.findByCusername(username);

		// Check if the user exists
		if (sysLogin == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.NOT_FOUND,
					"The given username was not found!");
		}

		sysLogin.unlockAccount();
		sysLogin.setNgraceLogins(getPasswortRuleValueAsInteger(PasswordRule.MAX_GRACE_LOGINS));
		sysLogin.setNfailedLogins(0);
	}

	/**
	 * Check the user, password, login tries, GraceLogin, expired date.
	 *
	 * @param user user from database
	 * @param password from request
	 * @return the login status
	 */
	@Transactional(noRollbackFor = CbaseMiddlewareUserLoginException.class)
	public CbaseMiddlewareUser checkUser(
			final CbaseMiddlewareUser user,
			final String password) {
		return checkUser(user, password, null);
	}

	/**
	 * Check the user, password, login tries, GraceLogin, expired date.
	 *
	 * @param user user from database
	 * @param password from request
	 * @param sapOdataModule the SAP OData module (if the user is a SAP user)
	 * @return the login status
	 */
	@Transactional(noRollbackFor = CbaseMiddlewareUserLoginException.class)
	public CbaseMiddlewareUser checkUser(
			final CbaseMiddlewareUser user,
			final String password,
			final String sapOdataModule) {
		LoginStatus loginStatus;
		final SysLogin sysLogin = user.getLogin();
		final String encryptReqPwd = encryptDecrypt(password, true, sysLogin.getCusername());

		if ("..--..".equals(password)) {
			throw new CbaseMiddlewareUserLoginException(LoginStatus.USER_PASSWORD_UNKNOWN, "Wrong password");
		}

		// user locked -> create protocol and throw exception
		if (sysLogin.isAccountLocked()) {
			addPwdProtocol(sysLogin, CbaseLoginHistKind.LOGIN_REFUSED_BECAUSE_OF_ACCOUNTLOCK, encryptReqPwd);
			throw new CbaseMiddlewareUserLoginException(LoginStatus.ACCOUNT_LOCKED,
					String.format("User account '%s' is locked ", sysLogin.getCusername()));
		}

		// no grace login available -> create protocol, lock account and throw Exception
		if (sysLogin.isGraceLoginsAvailable()) {
			addPwdProtocol(sysLogin, CbaseLoginHistKind.ACCOUNTLOCK_BECAUSE_OF_INACTIVITY, encryptReqPwd);
			sysLogin.lockAccount();
			throw new CbaseMiddlewareUserLoginException(LoginStatus.ACCOUNT_LOCKED,
					String.format("User account '%s' is locked! No grace login available. ", sysLogin.getCusername()));
		}

		// check SAP user, system(technical) user or normal user
		if (sapOdataModule != null && !sapOdataModule.isEmpty() && !"undefined".equals(sapOdataModule)) {
			loginStatus = checkSapUser(sapOdataModule, user, password);
		} else if (sysLogin.isTechUser()) {
			loginStatus = checkTechUser(sysLogin, encryptReqPwd);
		} else {
			loginStatus = checkNormalUser(sysLogin, encryptReqPwd);
		}

		// successful login reset grace logins, failed logins, last login date
		sysLogin.setNgraceLogins(getPasswortRuleValueAsInteger(PasswordRule.MAX_GRACE_LOGINS));
		sysLogin.setNfailedLogins(0);
		user.setLoginStatus(loginStatus);
		final Date currentDate = now();
		sysLogin.setDlastlogin(currentDate);
		// legacy code is removed in future, if all application use only the dlastLogin
		sysLogin.setClastlogin(DateFormatUtils.format(currentDate, FormatConstants.DATE_PATTERN));

		return handleSuccessPasswordExpired(user);
	}

	/**
	 * Check a SAP OData user for a specific SAP OData module
	 * 
	 * @param sapOdataModule the SAP OData module to check the user for
	 * @param sapLogin SAP login information
	 * @return the login status
	 */
	private LoginStatus checkSapUser(final String sapOdataModule, final CbaseMiddlewareUser user, final String password) {
		// check authorization in SAP
		try {
			final SapOdataLogin sapLogin = sapOdataHelper.startSession(sapOdataModule, user.getUsername(), password);
			user.setSapLogin(sapLogin);
		} catch (final IOException e) {
			CbaseMiddlewareUserDetailService.LOGGER.error(String.format("Failed to authorize for SAP OData module '%s'", sapOdataModule),
					e);

			throw new CbaseMiddlewareUserLoginException(LoginStatus.USER_PASSWORD_UNKNOWN, e);
		} catch (final CbaseMiddlewareBusinessException e) {
			final String errorMsg = String.format("Failed to authorize for SAP OData module '%s'", sapOdataModule);
			CbaseMiddlewareUserDetailService.LOGGER.error(errorMsg, e);

			if (e.getType() == CbaseMiddlewareBusinessExceptionType.SPECIAL_AUTHORIZATION) {
				throw new CbaseMiddlewareUserLoginException(LoginStatus.MISSING_ROLE, errorMsg, e);
			} else {
				throw new CbaseMiddlewareUserLoginException(LoginStatus.USER_PASSWORD_UNKNOWN, errorMsg, e);
			}
		}

		return LoginStatus.USER_AUTHORIZED;
	}

	/**
	 * Check technical(system) user (password cannot expire)
	 *
	 * @param sysLogin user from database
	 * @param encryptReqPwd password from request, but encrypted
	 * @return the login status
	 */
	private LoginStatus checkTechUser(final SysLogin sysLogin, final String encryptReqPwd) {
		checkPassword(sysLogin, encryptReqPwd);
		return LoginStatus.USER_AUTHORIZED;
	}

	/**
	 * Check normal user, has more checks as technical user.
	 *
	 * @param sysLogin user from database
	 * @param encryptReqPwd from request, but encrypted
	 * @return the login status
	 */
	private LoginStatus checkNormalUser(final SysLogin sysLogin, final String encryptReqPwd) {

		checkPassword(sysLogin, encryptReqPwd);

		// initial password
		final Date date = now();
		if (sysLogin.isInitPassword()) {
			final Integer initalPwdExpirePeriod = getPasswortRuleValueAsInteger(PasswordRule.INITAL_PASSORT_PERIOD);
			final Date expireDate = DateUtils.addDays(sysLogin.getDpwdDate(), initalPwdExpirePeriod);

			// initial password expired -> account locked, create protocol and throw exception
			if (expireDate.before(date)) {
				addPwdProtocol(sysLogin, CbaseLoginHistKind.ACCOUNTLOCK_BECAUSE_OF_INACTIVITY, encryptReqPwd);
				sysLogin.lockAccount();
				throw new CbaseMiddlewareUserLoginException(LoginStatus.ACCOUNT_LOCKED,
						String.format("User account '%s' is locked! Inital password is expired.", sysLogin.getCusername()));
			}

			// password is initial password and can still changed => login ok, change password
			return LoginStatus.PASSWORD_EXPIRED;
		}

		// check if password expired
		final Integer pwdExpirePeriod = getPasswortRuleValueAsInteger(PasswordRule.PASSWORD_PERIOD);
		final Date expireDate = DateUtils.addDays(sysLogin.getDpwdDate(), pwdExpirePeriod);
		if (expireDate.before(date)) {
			// password is expired
			return LoginStatus.PASSWORD_EXPIRED;

		}

		return LoginStatus.USER_AUTHORIZED;
	}

	/**
	 * Check if the max failed logins arrive and throw the {@link CbaseMiddlewareUserLoginException} with suitable {@link LoginStatus}
	 *
	 * @param sysLogin the current user ({@link SysLogin})
	 * @param encryptReqPwd from request, but encrypted
	 */
	private void checkPassword(final SysLogin sysLogin, final String encryptReqPwd) {
		if (!(encryptReqPwd.equals(sysLogin.getCuserPwd()))) {
			final Integer maxWrongLogin = getPasswortRuleValueAsInteger(PasswordRule.WRONG_PASSWORD_TILL_LOCK);
			Integer nfailedLogins = sysLogin.getNfailedLogins();
			nfailedLogins++;
			if (nfailedLogins > maxWrongLogin) {
				sysLogin.lockAccount();
				addPwdProtocol(sysLogin, CbaseLoginHistKind.ACCOUNTLOCK_BECAUSE_OF_WRONG_PASSWORD, encryptReqPwd);
				throw new CbaseMiddlewareUserLoginException(LoginStatus.ACCOUNT_LOCKED,
						"Wrong password and max failed login arrived. Acount is locked");
			}
			addPwdProtocol(sysLogin, CbaseLoginHistKind.WRONG_PASSWORD, encryptReqPwd);
			sysLogin.setNfailedLogins(nfailedLogins);
			throw new CbaseMiddlewareUserLoginException(LoginStatus.USER_PASSWORD_UNKNOWN, "Wrong password");
		}
	}

	/**
	 * If the current user has no encrypted and base64 encoded password(cuserPwd) or cuserPwd and cuserPassword are out of sync, the
	 * cuserPassword is encrypted, base64 encoded and save into cuserPwd. <br>
	 * legacy method is removed in future, if all user has a encrypted and base64 encoded cuserPwd and use fat client >= 530
	 *
	 * @param sysLogin the current user data
	 */
	private void encrypteDatabasePasswordIfNecessary(final SysLogin sysLogin) {
		final String encryptedDatabasePwd = encryptDecrypt(sysLogin.getCuserpassword(), true, sysLogin.getCusername());
		// legacy code is removed in future, if all user has a encrypted and base64 encoded cuserPwd
		if (StringUtils.isBlank(sysLogin.getCuserPwd())) {
			sysLogin.setCuserPwd(encryptedDatabasePwd);
			CbaseMiddlewareUserDetailService.LOGGER.info("No encrypted password. Encrypt the current plain text password. ");
		} else {
			// user has a encrypted password and change the password with an old application -> plain text and encrypted password out of
			// sync
			if (!encryptedDatabasePwd.equals(sysLogin.getCuserPwd())) {
				sysLogin.setCuserPwd(encryptedDatabasePwd);
				CbaseMiddlewareUserDetailService.LOGGER.info(
						"Plain text password and encrypted password adjust! The use of old applications (<530) leads to this difference.");
			}

		}
	}

	/**
	 * Create a password protocol entry.
	 *
	 * @param sysLogin the current user ({@link SysLogin})
	 * @param kind protocol entry type ({@link SysLoginHistKind}).
	 * @param encryptedPwd the given encrypted password
	 */
	private void addPwdProtocol(final SysLogin sysLogin, final CbaseLoginHistKind kind, final String encryptedPwd) {
		final HttpServletRequest request = getRequest();
		final SysLoginHistory sysLoginH = new SysLoginHistory();
		sysLoginH.setSysLoginHistkind(cbaseMiddlewareRepository.findOne(SysLoginHistKind.class, kind.getId()));
		sysLoginH.setCipadress(getRequest().getRemoteAddr());
		sysLoginH.setChostname(request.getRemoteHost());
		sysLoginH.setCversion(applicationNameAndVersion);
		sysLoginH.setSysLogin(sysLogin);
		sysLoginH.setCchangedByUser(sysLogin.getCusername());
		sysLoginH.setCusername(sysLogin.getCusername());
		sysLoginH.setDchange(now());
		sysLoginH.setCuserPwd(encryptedPwd);
		save(sysLoginH);
	}

	/**
	 * Check the user LoginStatus. If the Status is {@link LoginStatus#PASSWORD_EXPIRED}, the CbaseRole.PASSWORD_NOT_EXPIRED is detracted
	 * from user.
	 *
	 * @param user current user
	 * @return the new user object
	 */
	private CbaseMiddlewareUser handleSuccessPasswordExpired(final CbaseMiddlewareUser user) {
		if (user.getLoginStatus() == LoginStatus.PASSWORD_EXPIRED) {
			final Set<GrantedAuthority> authorities = new HashSet<>();
			for (final GrantedAuthority auth : user.getAuthorities()) {
				if (auth.getAuthority().contains(CbaseRole.ROLE_PWD_NOT_EXPIRED)) {
					continue;
				}
				authorities.add(auth);
			}
			return new CbaseMiddlewareUser(authorities, user.getLogin(), user.getPassword(), user.getLoginStatus(), user.getUserAgent(),
					user.getUserIp(), user.getRemoteHost());
		}

		return user;
	}

	/**
	 * Get the value for given password rule as Integer value.
	 *
	 * @param rule the search password rule
	 * @return the value of given password rule as Integer value
	 */
	public Integer getPasswortRuleValueAsInteger(final PasswordRule rule) {
		return Integer.parseInt(getPasswortRuleValue(rule));
	}

	/**
	 * Get the value for given password rule.
	 *
	 * @param rule the search password rule
	 * @return the value of given password rule
	 */
	public String getPasswortRuleValue(final PasswordRule rule) {
		final CenSetup cenSetup =
				cbaseMiddlewareRepository.findOne(CenSetup.class, new CenSetupId(getClient(), PasswordRule.getSection(), rule.getKey()));
		if (cenSetup != null) {
			return cenSetup.getCvalue();
		}

		return rule.getDefaultValue();
	}

	/**
	 * De- or encrypt the password. Use the MD5 for default secret key and RC4 as crypt algorithmus.
	 *
	 * @param password the password as String
	 * @param encrypt true if the password would be encrypted, false to decrypt the password
	 * @param username current user
	 * @return the decrypted or encrypted password.
	 */
	private String encryptDecrypt(final String password, final boolean encrypt, final String username) {
		try {
			final Charset charset = StandardCharsets.UTF_8;
			final int cryptMode = encrypt ? Cipher.ENCRYPT_MODE : Cipher.DECRYPT_MODE;

			final MessageDigest digest = MessageDigest.getInstance(CbaseMiddlewareUserDetailService.MD5);
			final byte[] hashSecret = digest.digest(CbaseMiddlewareUserDetailService.CRYPTO_KEY.getBytes(charset));

			final Cipher rc4 = Cipher.getInstance(CbaseMiddlewareUserDetailService.RC4);
			final SecretKeySpec rc4keySPec = new SecretKeySpec(hashSecret, CbaseMiddlewareUserDetailService.RC4);
			rc4.init(cryptMode, rc4keySPec);

			byte[] pwdBytes = password.getBytes(charset);
			if (Cipher.DECRYPT_MODE == cryptMode) { // encrypted password bytes are base64 encoded
				pwdBytes = Base64.getDecoder().decode(password.getBytes(charset));
			}

			byte[] bs = rc4.doFinal(pwdBytes);
			if (Cipher.ENCRYPT_MODE == cryptMode) { // encrypted password bytes must be base64 encoded
				bs = Base64.getEncoder().encode(bs);
			}

			return new String(bs, charset);
		} catch (final NoSuchAlgorithmException | InvalidKeyException | NoSuchPaddingException | IllegalBlockSizeException
				| BadPaddingException e) {
			CbaseMiddlewareUserDetailService.LOGGER
					.debug(String.format("Error to %s password! user: %s", encrypt ? "encrypt" : "decrypt", username), e);
			return null;
		}
	}

	/**
	 * The current request.
	 *
	 * @return the current request.
	 */
	private HttpServletRequest getRequest() {
		try {
			final RequestAttributes currentRequestAttributes = RequestContextHolder.currentRequestAttributes();
			return ((ServletRequestAttributes) currentRequestAttributes).getRequest();

		} catch (final IllegalStateException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, "Can't get current request!", e);
		}
	}

	/**
	 * Checks if a specific user has the given role.
	 * 
	 * @param username the specific username
	 * @param password the password for the specific user
	 * @param rolename the roleName to check
	 * @return {@code true} if the user has the role, otherwise {@code false}
	 */
	@Transactional(readOnly = true)
	public boolean userHasRole(
			final String username,
			final String password,
			final String rolename) {
		return userHasRole(username, password, rolename, null);
	}

	/**
	 * Checks if a specific user has the given role.
	 * 
	 * @param username the specific username
	 * @param password the password for the specific user
	 * @param rolename the roleName to check
	 * @param sapOdataModule the SAP OData module (if the user is a SAP user)
	 * @return {@code true} if the user has the role, otherwise {@code false}
	 */
	@Transactional(readOnly = true)
	public boolean userHasRole(
			final String username,
			final String password,
			final String rolename,
			final String sapOdataModule) {
		CbaseMiddlewareUser user = loadUserByUsername(username);
		user = checkUser(user, password, sapOdataModule);

		if (user.getLoginStatus() == LoginStatus.ACCOUNT_LOCKED) {
			return false;
		}

		return user.hasRole(rolename);
	}
}
