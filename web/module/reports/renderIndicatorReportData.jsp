<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="__openmrs_hide_report_link" value="true"/>
<%@ include file="../run/localHeader.jsp"%>
<%--
  This page assumes a ReportData object in the session as the attribute '__openmrs_report_data'
--%>

<style type="text/css">
	#wrapper input, #wrapper select, #wrapper textarea, #wrapper label, #wrapper button, #wrapper span, #wrapper div { font-size: large; } 
	form ul { margin:0; padding:0; list-style-type:none; width:100%; }
	form li { display:block; margin:0; padding:6px 5px 9px 9px; clear:both; color:#444; }
	fieldset { padding: 5px; margin:5px; }
	fieldset legend { font-weight: bold; background: #E2E4FF; padding: 6px; border: 1px solid black; }
	label.desc { line-height:150%; margin:0; padding:0 0 3px 0; border:none; color:#222; display:block; font-weight:bold; }
	.errors { margin-left:200px; margin-top:20px; margin-bottom:20px; font-family:Verdana,Arial,sans-serif; font-size:12px; }
	#report-schema-basic-tab { margin: 50px; }
	#wrapper { margin-top: 50px; }
</style>

<openmrs:portlet url="currentReportHeader" moduleId="reporting" parameters="showDiscardButton=true"/>

<div id="page">
	<div id="container">
		<div align="center">
			<c:forEach var="dataSetMapEntry" items="${__openmrs_report_data.dataSets}">
				<table cellpadding="2" style="border: 1px solid black;">					
					<rpt:forEach var="dataSetRow" items="${dataSetMapEntry.value}" varStatus="varStatus">
						<c:if test="${varStatus.first}">
							<tr>
								<th colspan="4" align="center" style="background-color: #8FABC7">
									<span style="color: white;">${dataSetMapEntry.value.definition.name}</span>
								</th>
							</tr>
						</c:if>
							<c:forEach var="dataSetCol" items="${dataSetRow.columnValues}">
								<tr>
								<%-- 
								 <c:url var="url" value="/module/reporting/dashboard/manageCohortDashboard.form?cohort=none&indicator=${dataSetCol.key.indicator.parameterizable.uuid}"/>
								--%>
								<c:url var="url"  value="/module/reporting/dashboard/viewCohortDataSet.form?savedDataSetKey=${dataSetMapEntry.key}&savedColumnKey=${dataSetCol.key.name}"/>
									<td align="left">
										${dataSetCol.key.name}
									</td>
									<td align="left">
										${dataSetCol.key.label}
									</td>
									<td align="center" class="value" width="1%" nowrap>
										<c:set var="result" value="${dataSetCol.value}"/>
										<a style="text-decoration: underline" href="${url}">${result.value}</a>
									</td>
									<%--
									<td align="center">
										<c:catch var="exception">
											<c:set var="infoUrl" value="${pageContext.request.contextPath}/module/reporting/indicators/indicatorInfo.form?uuid=${result.definition.uuid}&location=${result.context.parameterValues['location'].locationId}"/>
											<a href="#" onClick="showReportingDialog({ title: 'Indicator Info', url: '${infoUrl}' });">
												<img src="${pageContext.request.contextPath}/images/info.gif" border="0"/>
											</a>
										</c:catch>
									</td>
									 --%>
								</tr>
							</c:forEach>
					</rpt:forEach>
					<tfoot>
						<tr >
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<td height="25px" valign="bottom" colspan="4" align="right">
								<span style="font-size: small">
									generated by <strong>${authenticatedUser.username}</strong> | 
									<fmt:formatDate type="date" value="${now}"/> <fmt:formatDate type="time" value="${now}"/>
								</span>
							</td>
								
						</tr>
					</tfoot>
				</table>
			</c:forEach>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/template/footer.jsp"%>