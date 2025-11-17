package com.lsgskychefs.cbase.middleware.citp.common.pojo;

public class CateringFiguresObject {

    private Number jobNr;
    private Number classNr;
    private String classCode;
    private Number function;
    private Number pax;
    private String comment;


    public CateringFiguresObject(Number jobNr, Number classNr,
                                 String classCode, Number function, Number pax, String comment) {
        super();
        this.jobNr = jobNr;
        this.classNr = classNr;
        this.classCode = classCode;
        this.function = function;
        this.pax = pax;
        this.comment = comment;
    }

    public CateringFiguresObject(Object[] row) {
        this(
                (Number)row[0],
                (Number)row[1],
                (String)row[2],
                (Number)row[3],
                (Number)row[4],
                (String)row[5]
        );
    }

    public Number getJobNr() {
        return jobNr;
    }

    public Number getClassNr() {
        return classNr;
    }

    public String getClassCode() {
        return classCode;
    }

    public Number getFunction() {
        return function;
    }

    public Number getPax() {
        return pax;
    }

    public String getComment() {
        return comment;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[jobNr class=").append(jobNr != null ? jobNr.getClass().getSimpleName() + " value=" + jobNr.toString() : "IS NULL");
        sb.append("|classNr class=").append(classNr != null ? classNr.getClass().getSimpleName() + " value=" + classNr.toString() : "IS NULL");
        sb.append("|classCode class=").append(classCode != null ? classCode.getClass().getSimpleName() + " value=" + classCode : "IS NULL");
        sb.append("|function class=").append(function != null ? function.getClass().getSimpleName() + " value=" + function.toString() : "IS NULL");
        sb.append("|pax class=").append(pax != null ? pax.getClass().getSimpleName() + " value=" + pax.toString() : "IS NULL");
        sb.append("|comment class=").append(comment != null ? comment.getClass().getSimpleName() + " value=" + comment : "IS NULL");
        sb.append("]");
        return sb.toString();
    }
}
