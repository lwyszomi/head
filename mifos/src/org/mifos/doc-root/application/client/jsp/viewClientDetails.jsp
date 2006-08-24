<!-- /**

* viewClientDetails.jsp    version: 1.0



* Copyright (c) 2005-2006 Grameen Foundation USA

* 1029 Vermont Avenue, NW, Suite 400, Washington DC 20005

* All rights reserved.



* Apache License
* Copyright (c) 2005-2006 Grameen Foundation USA
*

* Licensed under the Apache License, Version 2.0 (the "License"); you may
* not use this file except in compliance with the License. You may obtain
* a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
*

* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and limitations under the

* License.
*
* See also http://www.apache.org/licenses/LICENSE-2.0.html for an explanation of the license

* and how it is applied.

*

*/
 -->
<%@ taglib uri="/mifos/customtags" prefix="mifoscustom"%>
<%@taglib uri="/tags/mifos-html" prefix="mifos"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="/userlocaledate" prefix="userdatefn"%>
<%@ taglib uri="/mifos/custom-tags" prefix="customtags"%>

<!-- Tils definition for the header and menu -->
<tiles:insert definition=".clientsacclayoutsearchmenu">
	<tiles:put name="body" type="string">
		<script language="javascript">

	function ViewDetails(){
		closedaccsearchactionform.submit();
	}
  function GoToEditPage(){
	centerActionForm.action="clientCreationAction.do?method=manage";
	centerActionForm.submit();
  }
  function photopopup(custId , custName){
	
   window.open("clientCustAction.do?method=showPicture&customerId="+ custId + "&displayName=" + custName,null,"height=250,width=200,status=no,scrollbars=no,toolbar=no,menubar=no,location=no");

  }

</script>

		<html-el:form action="clientCustAction.do">
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="bluetablehead05"><span class="fontnormal8pt"> <customtags:headerLink
						selfLink="false" /> </span>
				</tr>
			</table>
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="70%" align="left" valign="top" class="paddingL15T15">
					<table width="96%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td class="headingorange"><c:out
								value="${sessionScope.BusinessKey.displayName}" /></td>
							<td rowspan="2" align="right" valign="top" class="headingorange">
							<span class="fontnormal"> <!-- Edit center status link --> <c:if
								test="${sessionScope.BusinessKey.customerStatus.id != 6}">
								<a href="editCustomerStatusAction.do?method=load&customerId=<c:out value="${sessionScope.BusinessKey.customerId}"/>&securityParamInput=Client&input=client">
									<mifos:mifoslabel name="client.EditLink"
										bundle="ClientUIResources"></mifos:mifoslabel>
									<mifos:mifoslabel name="${ConfigurationConstants.CLIENT}" />
									<mifos:mifoslabel name="client.StatusLink"
										bundle="ClientUIResources"></mifos:mifoslabel>
								</a>
							</c:if> <br>
							</span></td>
						</tr>
						<tr>
							<td colspan="2"><font class="fontnormalRedBold"><html-el:errors
								bundle="ClientUIResources" /> </font></td>
						</tr>
						<tr>
							<td class="fontnormalbold"><span class="fontnormal"> <c:choose>
								<%-- Partial Application --%>
								<c:when
									test="${sessionScope.BusinessKey.customerStatus.id == 1}">
									<mifos:MifosImage id="partial" moduleName="customer.client" />

								</c:when>
								<%-- Pending Approval --%>
								<c:when
									test="${sessionScope.BusinessKey.customerStatus.id == 2}">
									<mifos:MifosImage id="pending" moduleName="customer.client" />
								</c:when>
								<%-- Active --%>
								<c:when
									test="${sessionScope.BusinessKey.customerStatus.id == 3}">
									<mifos:MifosImage id="active" moduleName="customer.client" />

								</c:when>
								<%-- On Hold --%>
								<c:when
									test="${sessionScope.BusinessKey.customerStatus.id == 4}">
									<mifos:MifosImage id="hold" moduleName="customer.client" />

								</c:when>
								<%-- Cancelled --%>
								<c:when
									test="${sessionScope.BusinessKey.customerStatus.id == 5}">
									<mifos:MifosImage id="cancelled" moduleName="customer.client" />

								</c:when>
								<%-- Closed --%>
								<c:when
									test="${sessionScope.BusinessKey.customerStatus.id == 6}">
									<mifos:MifosImage id="closed" moduleName="customer.client" />
								</c:when>

								<c:otherwise>
								</c:otherwise>
							</c:choose> <c:out
								value="${sessionScope.BusinessKey.customerStatus.name}" /> <c:forEach
								var="flagSet" items="${sessionScope.BusinessKey.customerFlags}">
								<span class="fontnormal"> <c:if
									test="${flagSet.statusFlag.blackListed}">
									<mifos:MifosImage id="blackListed" moduleName="customer.client" />
								</c:if> <c:out value="${flagSet.statusFlag.name}" /> </span>
							</c:forEach> </span><br>
							<!-- System Id of the center --> <span class="fontnormal"><mifos:mifoslabel
								name="client.SystemId" bundle="ClientUIResources"></mifos:mifoslabel>:</span>
							<span class="fontnormal"><c:out
								value="${sessionScope.BusinessKey.globalCustNum}" /></span><br>
							<!-- Loan Officer of the client --> <span class="fontnormal"> <mifos:mifoslabel
								name="client.LoanOff" bundle="ClientUIResources"></mifos:mifoslabel>
							<c:out value="${sessionScope.BusinessKey.personnel.displayName}" /></span><br>
						</tr>
						<tr id="Client.BusinessActivities">
							<td class="fontnormalbold"><span class="fontnormal"> <mifos:mifoslabel
								name="client.BusinessActivities" bundle="ClientUIResources"
								keyhm="Client.BusinessActivities"
								isManadatoryIndicationNotRequired="yes"></mifos:mifoslabel>
								<c:out value="${sessionScope.businessActivitiesEntityName}" /></span> <br>
						</tr>
						<tr>
							<td class="fontnormalbold"><span class="fontnormal"> <c:set
								var="custId" value="${sessionScope.BusinessKey.customerId}" />
							<c:set var="custName"
								value="${sessionScope.BusinessKey.personnel.displayName}" /> <%--	<c:if test="${sessionScope.noPictureOnGet eq 'No'}">
								<a href="javascript:photopopup(${custId} , '${custName}')"><mifos:mifoslabel
								name="client.seephoto" bundle="ClientUIResources"></mifos:mifoslabel></a>
							</c:if> --%></span><br>
							</td>
						</tr>
					</table>

					<!--- Accounts Information Begins -->
					<table width="96%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td width="36%" class="headingorange"><mifos:mifoslabel
								name="client.AccountHeading" bundle="ClientUIResources"></mifos:mifoslabel></td>
						</tr>
						<!-- bug id 28004. Added if condition to show link to open accounts if only client is active-->
						<c:if test="${sessionScope.BusinessKey.customerStatus.id == 3}">
							<tr align="right">
								<td class="headingorange"><span class="fontnormal"><mifos:mifoslabel
									name="client.AccountsLink" bundle="ClientUIResources"/>&nbsp; <html-el:link
									href="loanAccountAction.do?method=getPrdOfferings&customerId=${sessionScope.BusinessKey.customerId}">
									<mifos:mifoslabel name="${ConfigurationConstants.LOAN}" />
								</html-el:link> &nbsp;|&nbsp; <html-el:link
									href="savingsAction.do?method=getPrdOfferings&customerId=${sessionScope.BusinessKey.customerId}&recordOfficeId=${UserContext.branchId}&recordLoanOfficerId=${UserContext.id}">
									<mifos:mifoslabel name="${ConfigurationConstants.SAVINGS}" />
								</html-el:link> </span></td>
							</tr>
						</c:if>
					</table>
					<c:if test="${!empty sessionScope.customerActiveLoanAccounts}">
						<table width="96%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="63%" align="left" valign="top"
									class="tableContentLightBlue">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="63%"><span class="fontnormalbold"> <mifos:mifoslabel
											name="${ConfigurationConstants.LOAN}" /> </span> <span
											class="fontnormal"></span></td>
									</tr>
								</table>
								<span class="fontnormal"></span>
								<table width="95%" border="0" align="center" cellpadding="0"
									cellspacing="0">
									<c:forEach items="${sessionScope.customerActiveLoanAccounts}"
										var="loan">
										<tr>
											<td>
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="65%"><span class="fontnormal"> <html-el:link
														href="loanAccountAction.do?globalAccountNum=${loan.globalAccountNum}&method=get&recordOfficeId=${UserContext.branchId}&recordLoanOfficerId=${UserContext.id}">
														<c:out value="${loan.loanOffering.prdOfferingName}" />,Acct #<c:out
															value="${loan.globalAccountNum}" />
													</html-el:link> </span></td>
													<td width="35%"><span class="fontnormal"> <mifoscustom:MifosImage
														id="${loan.accountState.id}" moduleName="accounts.loan" />
													<c:out value="${loan.accountState.name}" /> </span></td>
												</tr>
											</table>
											<c:if
												test="${loan.accountState.id==5 || loan.accountState.id==9}">
												<span class="fontnormal"> <mifos:mifoslabel
													name="loan.outstandingbalance" />: <c:out
													value="${loan.loanSummary.oustandingBalance.amountDoubleValue}" /><br>
												<mifos:mifoslabel name="loan.amount_due" />: <c:out
													value="${loan.totalAmountDue.amountDoubleValue}" /> </span>
											</c:if></td>
										</tr>
										<tr>
											<td><img src="pages/framework/images/trans.gif" width="5"
												height="20"></td>
										</tr>
									</c:forEach>
								</table>
								</td>
							</tr>
						</table>

						<table width="50%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="pages/framework/images/trans.gif" width="10"
									height="10"></td>
							</tr>
						</table>
					</c:if> <c:if
						test="${!empty sessionScope.BusinessKey.activeSavingsAccounts}">
						<table width="96%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="63%" align="left" valign="top"
									class="tableContentLightBlue">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="63%"><span class="fontnormalbold"> <mifos:mifoslabel
											name="${ConfigurationConstants.SAVINGS}" /> </span> <span
											class="fontnormal"></span></td>
									</tr>
								</table>
								<span class="fontnormal"></span>
								<table width="95%" border="0" align="center" cellpadding="0"
									cellspacing="0">
									<c:forEach
										items="${sessionScope.BusinessKey.activeSavingsAccounts}"
										var="savings">
										<tr>
											<td>
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="65%"><span class="fontnormal"> <html-el:link
														href="savingsAction.do?globalAccountNum=${savings.globalAccountNum}&method=get&recordOfficeId=${UserContext.branchId}&recordLoanOfficerId=${UserContext.id}">
														<c:out value="${savings.savingsOffering.prdOfferingName}" />,Acct #<c:out
															value="${savings.globalAccountNum}" />
													</html-el:link> </span></td>
													<td width="35%"><span class="fontnormal"> <mifoscustom:MifosImage
														id="${savings.accountState.id}"
														moduleName="accounts.savings" /> <c:out
														value="${savings.accountState.name}" /> </span></td>
												</tr>
											</table>
											<span class="fontnormal"><mifos:mifoslabel
												name="Savings.balance" />: <c:out
												value="${savings.savingsBalance.amountDoubleValue}" /> </span></td>
										</tr>
										<tr>
											<td><img src="pages/framework/images/trans.gif" width="5"
												height="20"></td>
										</tr>
									</c:forEach>
								</table>
								</td>
							</tr>

						</table>
						<table width="50%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="pages/framework/images/trans.gif" width="10"
									height="10"></td>
							</tr>
						</table>
					</c:if>
					<table width="96%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="65%" height="69" align="left" valign="top"
								class="tableContentLightBlue"><span class="fontnormalbold"><mifos:mifoslabel
								name="${ConfigurationConstants.CLIENT}" /> <mifos:mifoslabel
								name="client.clientcharges" bundle="ClientUIResources" /></span>
							<table width="95%" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="53%"><span class="fontnormal"> <html-el:link
												href="javascript:ViewDetails()">
												<mifos:mifoslabel name="client.viewdetails"
													bundle="ClientUIResources" />
											</html-el:link> </span></td>
										</tr>
									</table>
									<span class="fontnormal"><mifos:mifoslabel name="client.amtdue"
										bundle="ClientUIResources" />: <c:out
										value="${sessionScope.BusinessKey.customerAccount.nextDueAmount}" />
									</span></td>
								</tr>

								<tr>
									<td><img src="pages/framework/images/trans.gif" width="5"
										height="5"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>

					<table width="96%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td width="69%" align="right" class="fontnormal"><span
								class="fontnormal"> <a
								href="customerAction.do?method=getAllClosedAccounts&customerId=<c:out value="${sessionScope.BusinessKey.customerId}"/>&type=client">
                  <mifos:mifoslabel name="client.ClosedAccountsLink" bundle="ClientUIResources" /></a> </span></td>
						</tr>
					</table>

					<!-- Account Info ends --> <!--- MFI Information Starts -->
					<table width="50%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="pages/framework/images/trans.gif" width="10"
								height="10"></td>
						</tr>
					</table>
					<table width="96%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td width="63%" height="23" class="headingorange"><mifos:mifoslabel
								name="client.MFIInformationHeading" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td width="37%" align="right" class="fontnormal"><html-el:link
								action="clientCustAction.do?method=editMfiInfo">
								<mifos:mifoslabel name="client.EditMfiInformationLink"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</html-el:link></td>
						</tr>
						<tr id="Client.ExternalId">
							<td height="23" colspan="2" class="fontnormalbold"><span
								class="fontnormal"> <mifos:mifoslabel
								name="${ConfigurationConstants.EXTERNALID}"
								keyhm="Client.ExternalId" isColonRequired="yes"
								isManadatoryIndicationNotRequired="yes" /> <c:out
								value="${sessionScope.BusinessKey.externalId}" /><br>
							</span>
						</tr>
						<tr>
							<td height="23" colspan="2" class="fontnormalbold"><span
								class="fontnormal"> <mifos:mifoslabel
								name="${ConfigurationConstants.CLIENT}"></mifos:mifoslabel> <mifos:mifoslabel
								name="client.ClientStartDate" bundle="ClientUIResources"></mifos:mifoslabel>:
							<!-- Bug Id 27911. Changed the all the dates in the clientDetails.jsp to display as per client Locale-->
							<c:out
								value="${userdatefn:getUserLocaleDate(sessionScope.UserContext.pereferedLocale,sessionScope.BusinessKey.createdDate)}" />
							<br>
							</span> <span class="fontnormal"><mifos:mifoslabel
								name="client.FormedBy" bundle="ClientUIResources"></mifos:mifoslabel></span>
							<span class="fontnormal"><c:out
								value="${sessionScope.BusinessKey.customerFormedByPersonnel.displayName}" />
							</span><br>

							<br>
							</td>
						</tr>
						<tr id="Client.TrainedDate">
							<td height="23" colspan="2" class="fontnormalbold"><mifos:mifoslabel
								name="client.TrainingStatus" bundle="ClientUIResources"></mifos:mifoslabel>
							<br>
							<!-- If the training status is set then the date is displayed -->
							<span class="fontnormal"> <mifos:mifoslabel
								name="client.TrainedOn" bundle="ClientUIResources"
								keyhm="Client.TrainedDate"
								isManadatoryIndicationNotRequired="yes"></mifos:mifoslabel> <!-- Bug Id 27911. Changed the all the dates in the clientDetails.jsp to display as per client Locale-->
							<c:out
								value="${userdatefn:getUserLocaleDate(sessionScope.UserContext.pereferedLocale,sessionScope.BusinessKey.trainedDate)}" />
							</span> <span class="fontnormal"><br>
							<br>
							</span> <!-- Group Membership details --></td>
						</tr>
						<tr>
							<td height="23" colspan="2" class="fontnormalbold">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="61%" class="fontnormalbold"><mifos:mifoslabel
										name="${ConfigurationConstants.GROUP}" /> <mifos:mifoslabel
										name="client.GroupMembershipDetails"
										bundle="ClientUIResources"></mifos:mifoslabel><br>
									<span class="fontnormalRed"> <mifos:mifoslabel
										name="client.MeetingsHeading" bundle="ClientUIResources" />:&nbsp;
									<c:out
										value="${sessionScope.BusinessKey.customerMeeting.meeting.meetingSchedule}" />
									<br>
									</span> <span class="fontnormal"> <c:if
										test="${sessionScope.BusinessKey.customerMeeting.meeting.meetingPlace!=null && !empty sessionScope.BusinessKey.customerMeeting.meeting.meetingPlace}">
										<c:out
											value="${sessionScope.BusinessKey.customerMeeting.meeting.meetingPlace}" />
										<br>
									</c:if> </span></td>
									<td width="39%" align="right" valign="top"><!-- Editing group or branch membership based on whether client belongs to group or not -->
									<c:choose>
										<c:when test="${sessionScope.BusinessKey.clientUnderGroup}">
											<html-el:link
												action="clientTransferAction.do?method=loadParents">
												<mifos:mifoslabel name="client.EditLink"
													bundle="ClientUIResources" />
												<mifos:mifoslabel name="${ConfigurationConstants.GROUP}" />
												<mifos:mifoslabel name="client.MembershipLink"
													bundle="ClientUIResources" />
											</html-el:link>
											<br>
										</c:when>
										<c:otherwise>
											<%--<c:if test="${sessionScope.configurationLSM eq 'No'}">--%>
												<html-el:link
													action="clientTransferAction.do?method=loadBranches">
													<mifos:mifoslabel name="client.EditLink"
														bundle="ClientUIResources" />
													<mifos:mifoslabel
														name="${ConfigurationConstants.BRANCHOFFICE}" />
													<mifos:mifoslabel name="client.MembershipLink"
														bundle="ClientUIResources" />
												</html-el:link>
											<%--</c:if>--%>
											<br>

											<c:choose>
												<c:when
													test="${ empty sessionScope.BusinessKey.customerMeeting.meeting}">
													<html-el:link
														action="MeetingAction.do?method=loadMeeting&input=ClientDetails&customerId=${sessionScope.BusinessKey.customerId}">
														<mifos:mifoslabel name="client.EditMeetingLink"
															bundle="ClientUIResources"></mifos:mifoslabel>
													</html-el:link>
												</c:when>
												<c:otherwise>
													<html-el:link
														action="MeetingAction.do?method=get&input=ClientDetails&meetingId=${sessionScope.BusinessKey.customerMeeting.meeting.meetingId}">
														<mifos:mifoslabel name="client.EditMeetingLink"
															bundle="ClientUIResources"></mifos:mifoslabel>
													</html-el:link>
												</c:otherwise>
											</c:choose>
											<br>
										</c:otherwise>
									</c:choose></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					<table width="50%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="pages/framework/images/trans.gif" width="10"
								height="10"></td>
						</tr>
					</table>
					<table width="96%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="50%" height="23" class="headingorange"><mifos:mifoslabel
								name="client.PersonalInformationHeading"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td width="50%" align="right" class="fontnormal"><html-el:link
								action="clientCustAction.do?method=editPersonalInfo">
								<mifos:mifoslabel name="client.EditPersonalInformationLink"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</html-el:link></td>
						</tr>
						<tr>
							<td class="fontnormal"><span class="fontnormal"> <mifos:mifoslabel
								name="client.DateOfBirth" bundle="ClientUIResources"></mifos:mifoslabel>
							<!-- Bug Id 27911. Changed the all the dates in the clientDetails.jsp to display as per client Locale-->
							<c:out
								value="${userdatefn:getUserLocaleDate(sessionScope.UserContext.pereferedLocale,sessionScope.BusinessKey.dateOfBirth)}" />;
							<c:out value="${sessionScope.age}" /> <mifos:mifoslabel
								name="client.YearsOld" bundle="ClientUIResources"></mifos:mifoslabel><br></td>
						</tr>
						<tr id="Client.GovernmentId">
							<td class="fontnormal"><mifos:mifoslabel
								name="${ConfigurationConstants.GOVERNMENT_ID}"
								keyhm="Client.GovernmentId" isColonRequired="yes"
								isManadatoryIndicationNotRequired="yes" /> <c:out
								value="${sessionScope.BusinessKey.governmentId}" /><br>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="fontnormal"><c:out value="${sessionScope.maritalStatusEntityName}" />
							<c:if
								test="${!empty sessionScope.BusinessKey.customerDetail.maritalStatus}">;</c:if>
							<c:out value="${sessionScope.spouseFatherValue}" />
							<mifos:mifoslabel name="client.Name" bundle="ClientUIResources"></mifos:mifoslabel>
							<c:out value="${sessionScope.spouseFatherName}" />
								<c:if
								test="${!empty sessionScope.BusinessKey.customerDetail.numChildren}">;
								<c:out
									value="${sessionScope.BusinessKey.customerDetail.numChildren}" />
								<mifos:mifoslabel name="client.Children"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</c:if><br>
							</td>
						</tr>
						<tr id="Client.Ethinicity">
							<td class="fontnormal">
							<c:if
								test="${!empty sessionScope.BusinessKey.customerDetail.ethinicity}">
								<c:out value="${sessionScope.ethinicityEntityName}" />
								<br>
							</c:if> 
							</td>
						</tr>
						<tr id="Client.EducationLevel">
							<td class="fontnormal"><c:if
								test="${!empty sessionScope.BusinessKey.customerDetail.educationLevel}">
								<c:out value="${sessionScope.educationLevelEntityName}" />
								<br>
							</c:if> 
							</td>
						</tr>
						<tr id="Client.Citizenship">
							<td class="fontnormal"><c:if
								test="${!empty sessionScope.BusinessKey.customerDetail.citizenship}">
								<mifos:mifoslabel name="${ConfigurationConstants.CITIZENSHIP}" keyhm="Client.Citizenship" isColonRequired="yes" isManadatoryIndicationNotRequired="yes"/>
								<c:out value="${sessionScope.citizenshipEntityName}" />
								<br>
							</c:if> 
							</td>
						</tr>
						<tr id="Client.Handicapped">
							<td class="fontnormal"><c:if
								test="${!empty sessionScope.BusinessKey.customerDetail.handicapped}">
								<mifos:mifoslabel name="${ConfigurationConstants.HANDICAPPED}" keyhm="Client.Handicapped" isColonRequired="yes" isManadatoryIndicationNotRequired="yes"/>
								<c:out value="${sessionScope.handicappedEntityName}" />
							</c:if></td>
						</tr>
						<c:if
							test="${not empty sessionScope.BusinessKey.customerAddressDetail.address.phoneNumber ||
					    				  not empty sessionScope.BusinessKey.customerAddressDetail.address.line1 ||
										  not empty sessionScope.BusinessKey.customerAddressDetail.address.line2 ||
										  not empty sessionScope.BusinessKey.customerAddressDetail.address.line3 ||
										  not empty sessionScope.BusinessKey.customerAddressDetail.address.city	 ||
										  not empty sessionScope.BusinessKey.customerAddressDetail.address.state	 ||
										  not empty sessionScope.BusinessKey.customerAddressDetail.address.country	 ||
										  not empty sessionScope.BusinessKey.customerAddressDetail.address.zip }">
							<tr id="Client.Address">
								<td class="fontnormalbold"><br>
								<mifos:mifoslabel name="client.Address"
									bundle="ClientUIResources" keyhm="Client.Address"
									isManadatoryIndicationNotRequired="yes"></mifos:mifoslabel> <span
									class="fontnormal"><br>
								</span> <c:if
									test="${!empty sessionScope.BusinessKey.displayAddress}">
									<span class="fontnormal"> <c:out
										value="${sessionScope.BusinessKey.displayAddress}" /> </span>
								</c:if></td>
							</tr>
							<tr id="Client.City">
								<td class="fontnormal"><c:if
									test="${!empty sessionScope.BusinessKey.customerAddressDetail.address.city}">
									<span class="fontnormal"><c:out
										value="${sessionScope.BusinessKey.customerAddressDetail.address.city}" />
									</span>
								</c:if></td>
							</tr>
							<tr id="Client.State">
								<td class="fontnormal"><c:if
									test="${!empty sessionScope.BusinessKey.customerAddressDetail.address.state}">
									<span class="fontnormal"> <c:out
										value="${sessionScope.BusinessKey.customerAddressDetail.address.state}" />
									</span>
								</c:if></td>
							</tr>
							<tr id="Client.Country">
								<td class="fontnormal"><c:if
									test="${!empty sessionScope.BusinessKey.customerAddressDetail.address.country}">
									<span class="fontnormal"><c:out
										value="${sessionScope.BusinessKey.customerAddressDetail.address.country}" />
									</span>
								</c:if></td>
							</tr>
							<tr id="Client.PostalCode">
								<td class="fontnormal"><c:if
									test="${!empty sessionScope.BusinessKey.customerAddressDetail.address.zip}">
									<span class="fontnormal"><c:out
										value="${sessionScope.BusinessKey.customerAddressDetail.address.zip}" />

									</span>
								</c:if></td>
							</tr>
							<tr id="Client.PhoneNumber">
								<td class="fontnormal"><span class="fontnormal"> <c:set
									var="phoneNumber"
									value="${sessionScope.BusinessKey.customerAddressDetail.address.phoneNumber}" />
								<c:if test="${!empty phoneNumber}">
									<br>
									<mifos:mifoslabel name="client.Telephone"
										bundle="ClientUIResources" keyhm="Client.PhoneNumber"
										isManadatoryIndicationNotRequired="yes"></mifos:mifoslabel>
									<c:out
										value="${sessionScope.BusinessKey.customerAddressDetail.address.phoneNumber}" />
								</c:if></span> <br>
						</c:if>
						<tr>
							<td height="23" colspan="2" class="fontnormalbold"><br>
							<c:if test="${!empty sessionScope.BusinessKey.customFields}">
								<span class="fontnormalbold"> <mifos:mifoslabel
									name="client.AdditionalInformationHeading"
									bundle="ClientUIResources"></mifos:mifoslabel> </span>
							</c:if> <span class="fontnormal"> <span class="fontnormal"><br>
							</span> <c:forEach var="cf" items="${sessionScope.customFields}">
								<c:forEach var="customField"
									items="${sessionScope.BusinessKey.customFields}">
									<c:if test="${cf.fieldId==customField.fieldId}">
										<c:choose>
											<c:when test="${cf.fieldType == 3}">
												<mifos:mifoslabel name="${cf.lookUpEntity.entityType}"
													bundle="CenterUIResources"></mifos:mifoslabel>: 
									         		<span class="fontnormal"><c:out
													value="${userdatefn:getUserLocaleDate(sessionScope.UserContext.pereferedLocale,customField.fieldValue)}" />
												</span>
											</c:when>
											<c:otherwise>
												<mifos:mifoslabel name="${cf.lookUpEntity.entityType}"
													bundle="CenterUIResources"></mifos:mifoslabel>: 
									         		<span class="fontnormal"><c:out
													value="${customField.fieldValue}" /> </span>
											</c:otherwise>
										</c:choose>
										<br>
									</c:if>
								</c:forEach>
							</c:forEach> <br>
							<!-- Bug Id 27210. Added code to pass the created date as parameter-->

							<a href="CustomerHistoricalDataAction.do?method=get&input=Client"><mifos:mifoslabel
								name="client.HistoricalDataLink" bundle="ClientUIResources"></mifos:mifoslabel>
							</a> <br>
							<html-el:link
								href="closedaccsearchaction.do?method=search&searchNode(search_name)=ChangeLogDetails&input=ViewClientLog&customerId=${sessionScope.BusinessKey.customerId}&entityTypeId=1&createdDate=${userdatefn:getUserLocaleDate(sessionScope.UserContext.pereferedLocale,sessionScope.BusinessKey.createdDate)}">
								<mifos:mifoslabel name="client.ChangeLogLink"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</html-el:link><br>
							</span> </td>
						</tr>
					</table>
					</td>
					<!-- Performance History -->
					<td width="30%" align="left" valign="top" class="paddingleft1">
					<table width="100%" border="0" cellpadding="2" cellspacing="0"
						class="bluetableborder">
						<tr>
							<td class="bluetablehead05"><span class="fontnormalbold"> <mifos:mifoslabel
								name="client.PerformanceHistoryHeading"
								bundle="ClientUIResources"></mifos:mifoslabel> </span></td>
						</tr>

						<tr>
							<td class="paddingL10"><img
								src="pages/framework/images/trans.gif" width="10" height="2"></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"><mifos:mifoslabel
								name="${ConfigurationConstants.LOAN}" /><mifos:mifoslabel
								name="client.CycleNo" bundle="ClientUIResources" /> <c:out
								value="${sessionScope.BusinessKey.performanceHistory.loanCycleNumber}" /></span></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"> <mifos:mifoslabel
								name="client.LastLoanAmount" bundle="ClientUIResources" /> <mifos:mifoslabel
								name="${ConfigurationConstants.LOAN}" isColonRequired="yes" />
							<c:out
								value="${sessionScope.BusinessKey.performanceHistory.lastLoanAmount}" /></span></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"><mifos:mifoslabel
								name="client.NoOfActive" bundle="ClientUIResources" /> <mifos:mifoslabel
								name="${ConfigurationConstants.LOAN}" isColonRequired="yes" />
							<c:out
								value="${sessionScope.BusinessKey.performanceHistory.noOfActiveLoans}" /></span></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"><mifos:mifoslabel
								name="client.DeliquentPortfolio" bundle="ClientUIResources" />
							<c:out
								value="${sessionScope.BusinessKey.performanceHistory.delinquentPortfolioAmount}" /></span></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"> <mifos:mifoslabel
								name="client.Total" bundle="ClientUIResources" /> <mifos:mifoslabel
								name="${ConfigurationConstants.SAVINGS}" isColonRequired="yes" />
							<c:out
								value="${sessionScope.BusinessKey.performanceHistory.totalSavingsAmount}" /></span></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"> <mifos:mifoslabel
								name="client.MeetingsAttended" bundle="ClientUIResources" /> <c:out
								value="${sessionScope.customerPerformance.meetingsAttended}" />
							</span></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"> <mifos:mifoslabel
								name="client.MeetingsMissed" bundle="ClientUIResources" /> <c:out
								value="${sessionScope.customerPerformanceHistory.meetingsMissed}" />
							</span></td>
						</tr>
						<tr>
							<td class="paddingL10"><span class="fontnormal8pt"> <mifos:mifoslabel
								name="${ConfigurationConstants.LOAN}" /> <mifos:mifoslabel
								name="label.loancyclecounter" bundle="CustomerUIResources"></mifos:mifoslabel>
							-</span></td>
						</tr>
						<c:forEach items="${sessionScope.loanCycleCounter}"
							var="loanCycle">
							<tr>
								<td class="paddingL10"><span class="fontnormal8pt">&nbsp;&nbsp;&nbsp;<c:out
									value="${loanCycle.offeringName}" />: <c:out
									value="${loanCycle.counter}" /></span></td>
							</tr>
						</c:forEach>
					</table>
					<table width="95%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="pages/framework/images/trans.gif" width="7"
								height="8"></td>
						</tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="0"
						class="bluetableborder">
						<tr>
							<td class="bluetablehead05"><span class="fontnormalbold"> <mifos:mifoslabel
								name="client.RecentNotes" bundle="ClientUIResources"></mifos:mifoslabel>
							</span></td>
						</tr>
						<tr>
							<td class="paddingL10"><img
								src="pages/framework/images/trans.gif" width="10" height="2"></td>
						</tr>
						<tr>
							<td class="paddingL10"><c:choose>
								<c:when test="${!empty sessionScope.BusinessKey.recentCustomerNotes}">
									<c:forEach var="note" items="${sessionScope.BusinessKey.recentCustomerNotes}">
										<span class="fontnormal8ptbold"> <!-- Bug Id 27911. Changed the all the dates in the clientDetails.jsp to display as per client Locale-->
										<c:out
											value="${userdatefn:getUserLocaleDate(sessionScope.UserContext.pereferedLocale,note.commentDate)}" />:
										</span>
										<span class="fontnormal8pt"> <c:out value="${note.comment}" />
										-<em><c:out value="${note.personnelName}" /></em><br>
										<br>
										</span>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<span class="fontnormal"> <mifos:mifoslabel
										name="Group.nonotesavailable" bundle="GroupUIResources" /> </span>
								</c:otherwise>
							</c:choose></td>
						</tr>
						<tr>
							<td align="right" class="paddingleft05"><span
								class="fontnormal8pt"> <c:if test="${!empty sessionScope.BusinessKey.customerNotes}">
								<html-el:link
									href="customerNotesAction.do?method=search&customerId=${sessionScope.BusinessKey.customerId}&globalAccountNum=${sessionScope.BusinessKey.globalCustNum}&customerName=${sessionScope.BusinessKey.displayName}&securityParamInput=Client&levelId=${sessionScope.BusinessKey.customerLevel.id}">
									<mifos:mifoslabel
									name="client.SeeAllNotesLink" bundle="ClientUIResources"></mifos:mifoslabel>
								</html-el:link>
								<br>
							</c:if> <a
								href="customerNotesAction.do?method=load&customerId=<c:out value="${sessionScope.BusinessKey.customerId}"/>">
							<mifos:mifoslabel name="client.NotesLink"
								bundle="ClientUIResources"></mifos:mifoslabel> </a> </span></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<br>
			<mifos:SecurityParam property="Client" />
		</html-el:form>
		<html-el:hidden property="globalAccountNum"
			value="${sessionScope.BusinessKey.customerAccount.globalAccountNum}" />
		<html-el:form action="closedaccsearchaction.do?method=search">
			<html-el:hidden property="searchNode(search_name)"
				value="ClientChargesDetails" />
			<html-el:hidden property="prdOfferingName"
				value="${sessionScope.BusinessKey.displayName}" />
			<html-el:hidden property="globalAccountNum"
				value="${sessionScope.BusinessKey.customerAccount.globalAccountNum}" />
			<html-el:hidden property="accountId"
				value="${sessionScope.BusinessKey.customerAccount.accountId}" />
			<html-el:hidden property="accountType"
				value="${sessionScope.BusinessKey.customerAccount.accountType.accountTypeId}" />
			<html-el:hidden property="input" value="ViewClientCharges" />
			<html-el:hidden property="customerId"
				value="${sessionScope.BusinessKey.customerId}" />
			<html-el:hidden property="statusId"
				value="${sessionScope.BusinessKey.customerStatus.id}" />
		</html-el:form>
	</tiles:put>
</tiles:insert>
