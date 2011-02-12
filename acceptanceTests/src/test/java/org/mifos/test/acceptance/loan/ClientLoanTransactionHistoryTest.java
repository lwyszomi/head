/*
 * Copyright Grameen Foundation USA
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an
 * explanation of the license and how it is applied.
 */

package org.mifos.test.acceptance.loan;

import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.SQLException;

import org.dbunit.DatabaseUnitException;
import org.dbunit.dataset.DataSetException;
import org.dbunit.dataset.IDataSet;
import org.joda.time.DateTime;
import org.mifos.framework.util.DbUnitUtilities;
import org.mifos.test.acceptance.collectionsheet.CollectionSheetEntryCustomerAccountTest;
import org.mifos.test.acceptance.framework.MifosPage;
import org.mifos.test.acceptance.framework.UiTestCaseBase;
import org.mifos.test.acceptance.framework.loan.CreateLoanAccountSearchParameters;
import org.mifos.test.acceptance.framework.loan.CreateLoanAccountSubmitParameters;
import org.mifos.test.acceptance.framework.loan.DisburseLoanParameters;
import org.mifos.test.acceptance.framework.loan.EditLoanAccountInformationParameters;
import org.mifos.test.acceptance.framework.loan.EditLoanAccountStatusParameters;
import org.mifos.test.acceptance.framework.loan.PaymentParameters;
import org.mifos.test.acceptance.framework.testhelpers.LoanTestHelper;
import org.mifos.test.acceptance.remote.DateTimeUpdaterRemoteTestingService;
import org.mifos.test.acceptance.remote.InitializeApplicationRemoteTestingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

@ContextConfiguration(locations={"classpath:ui-test-context.xml"})
@Test(sequential=true, groups={"acceptance", "ui", "loan"})
public class ClientLoanTransactionHistoryTest extends UiTestCaseBase {
    private LoanTestHelper loanTestHelper;

    @Autowired
    private DriverManagerDataSource dataSource;
    @Autowired
    private DbUnitUtilities dbUnitUtilities;
    @Autowired
    private InitializeApplicationRemoteTestingService initRemote;

    private DateTime systemDateTime;

    public static final String FEE_TRXN_DETAIL = "FEE_TRXN_DETAIL";
    public static final String FINANCIAL_TRXN = "FINANCIAL_TRXN";
    public static final String CUSTOMER_ACCOUNT_ACTIVITY = "CUSTOMER_ACCOUNT_ACTIVITY";
    public static final String CUSTOMER_TRXN_DETAIL = "CUSTOMER_TRXN_DETAIL";
    public static final String ACCOUNT_TRXN = "ACCOUNT_TRXN";
    public static final String LOAN_TRXN_DETAIL = "LOAN_TRXN_DETAIL";
    public static final String ACCOUNT_PAYMENT = "ACCOUNT_PAYMENT";
    public static final String LOAN_SUMMARY = "LOAN_SUMMARY";
    public static final String LOAN_SCHEDULE = "LOAN_SCHEDULE";
    public static final String LOAN_ACTIVITY_DETAILS = "LOAN_ACTIVITY_DETAILS";
    public static final String ACCOUNT_STATUS_CHANGE_HISTORY = "ACCOUNT_STATUS_CHANGE_HISTORY";


    @Override
    @SuppressWarnings("PMD.SignatureDeclareThrowsException")
    // one of the dependent methods throws Exception
    @BeforeMethod
    public void setUp() throws Exception {
        super.setUp();

        DateTimeUpdaterRemoteTestingService dateTimeUpdaterRemoteTestingService = new DateTimeUpdaterRemoteTestingService(selenium);
        systemDateTime = new DateTime(2009,2,7,12,0,0,0);
        dateTimeUpdaterRemoteTestingService.setDateTime(systemDateTime);

        loanTestHelper = new LoanTestHelper(selenium);
    }

    @AfterMethod
    public void logOut() {
        (new MifosPage(selenium)).logout();
    }

    //http://mifosforge.jira.com/browse/MIFOSTEST-361
    @SuppressWarnings("PMD.SignatureDeclareThrowsException")
    public void verifyTransactionHistoryWithDoubleEntryAccounting() throws DatabaseUnitException, SQLException, IOException, URISyntaxException{
        //Given
        initRemote.dataLoadAndCacheRefresh(dbUnitUtilities, "acceptance_small_011_dbunit.xml", dataSource, selenium);
        CreateLoanAccountSearchParameters searchParameters = new CreateLoanAccountSearchParameters();
        CreateLoanAccountSubmitParameters submitAccountParameters = new CreateLoanAccountSubmitParameters();
        searchParameters.setLoanProduct("WeeklyFlatLoanWithOneTimeFees");
        searchParameters.setSearchString("Stu1232993852651");
        submitAccountParameters.setAmount("2000.0");
        submitAccountParameters.setInterestRate("3.0");
        submitAccountParameters.setNumberOfInstallments("11");
        EditLoanAccountInformationParameters editLoanAccountInformationParameters = new EditLoanAccountInformationParameters();
        editLoanAccountInformationParameters.setCollateralNotes("collateralNotes");
        editLoanAccountInformationParameters.setExternalID("1234");
        editLoanAccountInformationParameters.setPurposeOfLoan("0005-Pig Raising");
        editLoanAccountInformationParameters.setCollateralType("Type 1");
        DisburseLoanParameters disburseParameters = new DisburseLoanParameters();
        disburseParameters.setDisbursalDateDD(Integer.toString(systemDateTime.getDayOfMonth()));
        disburseParameters.setDisbursalDateMM(Integer.toString(systemDateTime.getMonthOfYear()));
        disburseParameters.setDisbursalDateYYYY(Integer.toString(systemDateTime.getYear()));
        disburseParameters.setPaymentType(PaymentParameters.CASH);
        PaymentParameters paymentParameters = new PaymentParameters();
        paymentParameters.setAmount("200.0");
        paymentParameters.setTransactionDateDD(Integer.toString(systemDateTime.plusDays(10).getDayOfMonth()));
        paymentParameters.setTransactionDateMM(Integer.toString(systemDateTime.plusDays(10).getMonthOfYear()));
        paymentParameters.setTransactionDateYYYY(Integer.toString(systemDateTime.plusDays(10).getYear()));
        paymentParameters.setPaymentType(PaymentParameters.CASH);
        //When
        String loanId = loanTestHelper.createLoanAccount(searchParameters, submitAccountParameters).getAccountId();
        EditLoanAccountStatusParameters params = new EditLoanAccountStatusParameters();
        params.setStatus(EditLoanAccountStatusParameters.APPROVED);
        params.setNote("Approved.");
        loanTestHelper.changeLoanAccountStatus(loanId, params);
        //Then
        loanTestHelper.verifyLastEntryInStatusHistory(loanId, EditLoanAccountStatusParameters.PENDING_APPROVAL, EditLoanAccountStatusParameters.APPROVED);
        //When
        loanTestHelper.changeLoanAccountInformation(loanId, new CreateLoanAccountSubmitParameters(), editLoanAccountInformationParameters);
        loanTestHelper.disburseLoan(loanId, disburseParameters);
        loanTestHelper.setApplicationTime(systemDateTime.plusDays(10));
        loanTestHelper.applyPayment(loanId, paymentParameters);
        //Then
        loanTestHelper.verifyTransactionHistory(loanId, Double.valueOf(paymentParameters.getAmount()));
    }

    @SuppressWarnings("PMD.SignatureDeclareThrowsException")
    public void transactionHistoryTest() throws Exception {
        initRemote.dataLoadAndCacheRefresh(dbUnitUtilities, "acceptance_small_003_dbunit.xml", dataSource, selenium);

        /*
         * This test consists of:
         * 1. Make a single payment of the fee, 900
         * 2. Make a single payment of the principal and interest, 183.
         * 3. Verify the results (loan_trxn_detail table).
         *
         * The data set contains a loan w/ id 000100000000174 that's disbursed and who's loan
         * product contains a fee.
         */

        PaymentParameters paymentParameters = new PaymentParameters();
        paymentParameters.setAmount("990"); // this covers the fee (990)
        paymentParameters.setTransactionDateDD("06");
        paymentParameters.setTransactionDateMM("02");
        paymentParameters.setTransactionDateYYYY("2009");
        paymentParameters.setPaymentType(PaymentParameters.CASH);

        loanTestHelper.applyPayment("000100000000174", paymentParameters);

        // use the same date and payment type for the principal and the interest
        paymentParameters.setAmount("183");
        loanTestHelper.applyPayment("000100000000174", paymentParameters);

        verifyCollectionSheetData("ClientLoanTransactionHistory_001_result_dbunit.xml");
    }


    // the code below is the same that's used in CollectionSheetEntryCustomerAccountTest.

    @SuppressWarnings("PMD.SignatureDeclareThrowsException") // one of the dependent methods throws Exception
    private void verifyCollectionSheetData(String filename) throws Exception {
        IDataSet expectedDataSet = dbUnitUtilities.getDataSetFromDataSetDirectoryFile(filename);
        IDataSet databaseDataSet = dbUnitUtilities.getDataSetForTables(dataSource, new String[] { FEE_TRXN_DETAIL,
                                   ACCOUNT_TRXN,
                                   LOAN_TRXN_DETAIL,
                                   ACCOUNT_PAYMENT,
                                   LOAN_SCHEDULE,
                                   LOAN_SUMMARY,
                                   LOAN_ACTIVITY_DETAILS,
                                   ACCOUNT_STATUS_CHANGE_HISTORY,
                                   FINANCIAL_TRXN,
                                   CUSTOMER_ACCOUNT_ACTIVITY,
                                   CUSTOMER_TRXN_DETAIL });


        verifyTablesWithoutSorting(expectedDataSet, databaseDataSet);

        /* The order that the transactions are entered into the database (and accordingly the
         * id that they're assigned) is as far as I can tell random. This means that the sorting
         * is random and not verifyable.
         */
        //verifyTransactionsAfterSortingTables(expectedDataSet, databaseDataSet);

    }
    private void verifyTablesWithoutSorting(IDataSet expectedDataSet, IDataSet databaseDataSet) throws DataSetException,
    DatabaseUnitException {
        dbUnitUtilities.verifyTables(new String[] { CollectionSheetEntryCustomerAccountTest.CUSTOMER_ACCOUNT_ACTIVITY }, databaseDataSet, expectedDataSet);
    }
}