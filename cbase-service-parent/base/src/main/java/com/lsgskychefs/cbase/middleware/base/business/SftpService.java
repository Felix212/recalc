/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import java.io.InputStream;
import java.io.OutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;

/**
 * Provide sFTP handling.
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class SftpService extends AbstractCbaseMiddlewareService {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(SftpService.class);

	/** sFTP port */
	private static final int SFTP_PORT = 22;

	/**
	 * Send content as file to given host with given configuration.
	 *
	 * @param content the content to send as file
	 * @param fileName the name of sent date
	 * @param sFTPHost the destination hostname or IP
	 * @param sFTPUser the user name
	 * @param sFTPPassword the user password
	 * @param sFTPWorkingDir path
	 */
	public void send(final InputStream content, final String fileName, final String sFTPHost, final String sFTPUser,
			final String sFTPPassword, final String sFTPWorkingDir) {

		Session session = null;
		Channel channel = null;
		ChannelSftp channelSftp = null;
		LOGGER.debug("preparing the host information for sftp.");
		try {
			final JSch jsch = new JSch();
			session = jsch.getSession(sFTPUser, sFTPHost, SFTP_PORT);
			session.setPassword(sFTPPassword);

			final java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			LOGGER.info("Try to connect to Host '{}' with user '{}' into directory '{}'.", sFTPHost, sFTPUser, sFTPWorkingDir);
			session.connect();
			LOGGER.info("Host connected.");

			channel = session.openChannel("sftp");
			channel.connect();
			LOGGER.debug("sftp channel opened and connected.");

			channelSftp = (ChannelSftp) channel;
			channelSftp.cd(sFTPWorkingDir);
			channelSftp.put(content, fileName);
			LOGGER.info("File '{}' transferred successfully to host.", fileName);

		} catch (SftpException | JSchException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, "Failed to send file via sftp!", e);
		} finally {
			if (channelSftp != null) {
				channelSftp.exit();
				LOGGER.debug("sftp channel exited.");
			}
			if (channel != null) {
				channel.disconnect();
				LOGGER.debug("Channel disconnected.");
			}
			if (session != null) {
				session.disconnect();
				LOGGER.debug("Host session disconnected.");
			}
		}
	}

	/**
	 * Reads the content from a file and write it to the given output stream
	 * 
	 * @param out the output stream to write the file
	 * @param fileName the path to the desired file relative from sFTPWorkingDir
	 * @param sFTPHost the destination hostname or IP
	 * @param sFTPUser the user name
	 * @param sFTPPassword the user password
	 * @param sFTPWorkingDir the root path - changeDirectory (cd) to this is done
	 * @return
	 */
	public void read(final OutputStream out, final String fileName, final String sFTPHost, final String sFTPUser,
			final String sFTPPassword, final String sFTPWorkingDir) {

		Session session = null;
		Channel channel = null;
		ChannelSftp channelSftp = null;

		LOGGER.debug("preparing the host information for sftp.");
		try {
			final JSch jsch = new JSch();
			session = jsch.getSession(sFTPUser, sFTPHost, SFTP_PORT);
			session.setPassword(sFTPPassword);

			final java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			LOGGER.info("Try to connect to Host '{}' with user '{}' into directory '{}'.", sFTPHost, sFTPUser);
			session.connect();
			LOGGER.info("Host connected.");

			channel = session.openChannel("sftp");
			channel.connect();
			LOGGER.debug("sftp channel opened and connected.");

			channelSftp = (ChannelSftp) channel;
			channelSftp.cd("/" + sFTPWorkingDir);
			channelSftp.get(fileName, out);
			LOGGER.info("File '{}' transfered successfully from host.", fileName);

		} catch (SftpException | JSchException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, "Error to read file via sFTP!", e);
		} finally {
			if (channelSftp != null) {
				channelSftp.exit();
				LOGGER.debug("sftp Channel exited.");
			}
			if (channel != null) {
				channel.disconnect();
				LOGGER.debug("Channel disconnected.");
			}
			if (session != null) {
				session.disconnect();
				LOGGER.debug("Host Session disconnected.");
			}
		}
	}
}
