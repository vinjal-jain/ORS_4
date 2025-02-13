package com.rays.pro4.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.StaffBean;
import com.rays.pro4.Bean.StaffBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DuplicateRecordException;

import com.rays.pro4.Model.StaffModel;
import com.rays.pro4.Model.StaffModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.DataValidator;
import com.rays.pro4.Util.PropertyReader;
import com.rays.pro4.Util.ServletUtility;

//TODO: Auto-generated Javadoc
/**
 * The Class StaffCtl.
 * 
 * @author Vinjal Jain
 * 
 */
@WebServlet(name = "StaffCtl", urlPatterns = { "/ctl/StaffCtl" })
public class StaffCtl extends BaseCtl {

	private static final long serialVersionUID = 1L;

	/** The log. */
	private static Logger log = Logger.getLogger(StaffCtl.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see in.co.rays.ors.controller.BaseCtl#validate(javax.servlet.http.
	 * HttpServletRequest)
	 */
	@Override
	protected boolean validate(HttpServletRequest request) {
		System.out.println("uctl Validate");
		log.debug("StaffCtl Method validate Started");

		boolean pass = true;

		if (DataValidator.isNull(request.getParameter("fullName"))) {
			request.setAttribute("fullName", PropertyReader.getValue("error.require", "FullName"));
			pass = false;
		} else if (!DataValidator.isName(request.getParameter("fullName"))) {
			request.setAttribute("fullName", "FullName contains alphabet only");
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("division"))) {
			request.setAttribute("division", PropertyReader.getValue("error.require", "Division"));
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("joiningDate"))) {
			request.setAttribute("joiningDate", PropertyReader.getValue("error.require", "Joining Date"));
			pass = false;
		} else if (!DataValidator.isDate(request.getParameter("joiningDate"))) {
			request.setAttribute("joiningDate", PropertyReader.getValue("error.date", "Joining Date"));
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("previousEmployer"))) {
			request.setAttribute("previousEmployer", PropertyReader.getValue("error.require", "Previous Employer"));
			pass = false;
		} else if (!DataValidator.isName(request.getParameter("previousEmployer"))) {
			request.setAttribute("previousEmployer", "Previous Employer contains alphabet only");
			pass = false;
		}

		log.debug("StaffCtl Method validate Ended");

		return pass;
	}

	@Override
	protected void preload(HttpServletRequest request) {

		Map<Integer, String> map = new HashMap();

		map.put(1, "IT");
		map.put(2, "AI");
		map.put(3, "ML");

		request.setAttribute("staff", map);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see in.co.rays.ors.controller.BaseCtl#populateBean(javax.servlet.http.
	 * HttpServletRequest)
	 */

	/**
	 * This is Populate Bean
	 */
	protected BaseBean populateBean(HttpServletRequest request) {
		System.out.println(" uctl Base bean P bean");
		log.debug("StaffCtl Method populatebean Started");

		StaffBean bean = new StaffBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));

		bean.setFullName(DataUtility.getString(request.getParameter("fullName")));

		bean.setDivision(DataUtility.getInt(request.getParameter("division")));

		bean.setJoiningDate(DataUtility.getDate(request.getParameter("joiningDate")));

		bean.setPreviousEmployer(DataUtility.getString(request.getParameter("previousEmployer")));

		log.debug("StaffCtl Method populatebean Ended");

		return bean;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("StaffCtl Method doGet Started");

		String op = DataUtility.getString(request.getParameter("operation"));
		// get model
		StaffModel model = new StaffModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		System.out.println("Staff Edit Id >= " + id);
		if (id != 0 && id > 0) {
			System.out.println("in id > 0  condition");
			StaffBean bean;
			try {
				bean = model.findByPK(id);
				System.out.println(bean);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}
		}

		ServletUtility.forward(getView(), request, response);
		log.debug("StaffCtl Method doGet Ended");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("uctl Do Post");

		log.debug("StaffCtl Method doPost Started");

		String op = DataUtility.getString(request.getParameter("operation"));
		long id = DataUtility.getLong(request.getParameter("id"));

		StaffModel model = new StaffModel();
		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			StaffBean bean = (StaffBean) populateBean(request);
			System.out.println(" U ctl DoPost 11111111");

			try {
				if (id > 0) {

					// System.out.println("hi i am in dopost update");

					model.update(bean);
					ServletUtility.setBean(bean, request);
					System.out.println(" U ctl DoPost 222222");
					ServletUtility.setSuccessMessage("Staff is successfully Updated", request);

				} else {
					System.out.println(" U ctl DoPost 33333");
					long pk = model.add(bean);

					bean = model.findByPK(pk);

					ServletUtility.setBean(bean, request);

					ServletUtility.setSuccessMessage("Staff is successfully Added", request);
					/*
					 * ServletUtility.forward(getView(), request, response);
					 */ }
				/*
				 * ServletUtility.setBean(bean, request);
				 * ServletUtility.setSuccessMessage("Staff is successfully saved", request);
				 */

			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			} catch (DuplicateRecordException e) {
				System.out.println(" U ctl D post 4444444");
				ServletUtility.setBean(bean, request);
				ServletUtility.setErrorMessage("Login id already exists", request);
			}
		} else if (OP_DELETE.equalsIgnoreCase(op)) {
			System.out.println(" U ctl D p 5555555");

			StaffBean bean = (StaffBean) populateBean(request);
			try {
				model.delete(bean);
				System.out.println(" u ctl D Post  6666666");
				ServletUtility.redirect(ORSView.STAFF_CTL, request, response);
				return;
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}

		} else if (OP_CANCEL.equalsIgnoreCase(op)) {
			System.out.println(" U  ctl Do post 77777");

			ServletUtility.redirect(ORSView.STAFF_LIST_CTL, request, response);
			return;
		}
		ServletUtility.forward(getView(), request, response);

		log.debug("StaffCtl Method doPostEnded");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see in.co.rays.ors.controller.BaseCtl#getView()
	 */
	@Override
	protected String getView() {
		return ORSView.STAFF_VIEW;
	}

}