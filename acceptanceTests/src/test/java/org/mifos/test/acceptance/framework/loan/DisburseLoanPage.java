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

package org.mifos.test.acceptance.framework.loan;

import org.mifos.test.acceptance.framework.MifosPage;
import org.mifos.test.acceptance.framework.HomePage;
import org.testng.Assert;

import com.thoughtworks.selenium.Selenium;


public class DisburseLoanPage extends MifosPage {

    public DisburseLoanPage(Selenium selenium) {
        super(selenium);
        this.verifyPage("DisburseLoan");
    }

    public DisburseLoanConfirmationPage submitAndNavigateToDisburseLoanConfirmationPage(DisburseLoanParameters params) {
        this.typeTextIfNotEmpty("transactionDateDD", params.getDisbursalDateDD());
        this.typeTextIfNotEmpty("transactionDateMM", params.getDisbursalDateMM());
        this.typeTextIfNotEmpty("transactionDateYY", params.getDisbursalDateYYYY());

        this.typeTextIfNotEmpty("DisburseLoan.input.receiptId", params.getReceiptId());

        this.typeTextIfNotEmpty("receiptDateDD", params.getReceiptDateDD());
        this.typeTextIfNotEmpty("receiptDateMM", params.getReceiptDateMM());
        this.typeTextIfNotEmpty("receiptDateYY", params.getReceiptDateYYYY());

        this.typeTextIfNotEmpty("DisburseLoan.input.disbursementAmount", params.getAmount());

        selenium.select("DisburseLoan.input.paymentType", "value=" + params.getPaymentTypeValue());

        selenium.click("DisburseLoan.button.reviewTransaction");

        // there are some options for Payment but they're always
        // disabled.

        waitForPageToLoad();
        return new DisburseLoanConfirmationPage(selenium);
    }

    public void verifyPaymentModeOfPaymentIsEditable(String message) {
        Assert.assertTrue(selenium.isEditable("paymentModeOfPayment"), message);
    }

    public void verifyPaymentModesOfPaymentAreEmpty() {
        Assert.assertEquals(selenium.getSelectedValue("DisburseLoan.input.paymentType"), "");
        Assert.assertEquals(selenium.getSelectedValue("paymentModeOfPayment"), "");
    }

    public void verifyDisbursalDateIsDisabled(){
        Assert.assertFalse(selenium.isEditable("transactionDateDD"));
        Assert.assertFalse(selenium.isEditable("transactionDateMM"));
        Assert.assertFalse(selenium.isEditable("transactionDateYY"));
    }

    public void setModesOfPaymentAndReviewTransaction() {
        selenium.select("DisburseLoan.input.paymentType", "label=" + DisburseLoanParameters.CASH);
        selenium.select("paymentModeOfPayment", "label=" + DisburseLoanParameters.CASH);

        selenium.click("DisburseLoan.button.reviewTransaction");

        waitForPageToLoad();
    }

    public HomePage navigateToHomePage() {
        selenium.click("id=clientsAndAccountsHeader.link.home");
        waitForPageToLoad();
        return new HomePage(selenium);
    }
}
