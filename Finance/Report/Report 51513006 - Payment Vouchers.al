report 51513006 "Payment Vouchers"
{
    // version FINANCE

    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Payment Vouchers.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
             DataItemTableView = sorting ("Primary Key");
            column(Nam1e; Name)
            {

            }
            column(Picture; Picture)
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
            {

            }
            column(Address; Address)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            dataitem(Payments; "Payments HeaderFin")
            {
                DataItemTableView = SORTING ("No.");
                RequestFilterFields = "No.";
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(STRSUBSTNO_TXT002_CompanyInfo_Address_CompanyInfo__Post_Code__CompanyInfo_City_; STRSUBSTNO(Text100, CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo."Phone No.", CompanyInfo."E-Mail", CompanyInfo."Home Page"))
                {
                }
                column(ContactInfo; STRSUBSTNO(TXT002, CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo.City))
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(PayeeBankName; PayeeBankName)
                {
                }
                column(BankName_Payments1; PayeeBankName)
                {
                }
                column(PayingBankAccount_Payments; Payments."Paying Bank Account")
                {
                }
                column(Payments1_Payments1_No; "No.")
                {
                }
                column(Payments1_Payments1__Cheque_No_; Payments."Cheque No")
                {
                }
                column(Payments_Cheque_Date; Payments."Cheque Date")
                {
                }
                column(Payments1_Payments1_Date; Payments.Date)
                {
                }
                column(PayMode_Payments; Payments."Pay Mode")
                {
                }
                column(Payments1_Payments1_Payee; Payments.Payee)
                {
                }
                column(PayeeAddress; PayeeAddress)
                {
                }
                column(NumberText_1_; NumberText[1])
                {
                }
                column(NumberText_2_; NumberText[2])
                {
                }
                column(PreparedbyName; Payments.Cashier)
                {
                }
                column(AuthorizedName; AuthorizedName)
                {
                }
                column(V1stapprover_; "1stapprover")
                {
                }
                column(EmptyString; '_______________________________________')
                {
                }
                column(V2ndapprover_; "2ndapprover")
                {
                }
                column(V2ndapproverdate_; "2ndapproverdate")
                {
                }
                column(V3rdapproverdate_; "3rdapproverdate")
                {
                }
                column(UserRecApp1_Picture; UserRecApp1.Picture)
                {
                }
                column(UserRecApp2_Picture; UserRecApp2.Picture)
                {
                }
                column(ChequeNo_Payments; Payments."Cheque No")
                {
                }
                column(V3rdapprover_; "3rdapprover")
                {
                }
                column(UserRecApp3_Picture; UserRecApp3.Picture)
                {
                }
                column(Designation_1; Designation1)
                {
                }
                column(Designation_2; Designation2)
                {
                }
                column(Designation_3; Designation3)
                {
                }
                column(V1stapproverdate_; "1stapproverdate")
                {
                }
                column(PAYMENT_VOUCHERCaption; PAYMENT_VOUCHERCaptionLbl)
                {
                }
                column(BANK_NAMECaption; BANK_NAMECaptionLbl)
                {
                }
                column(VOUCHER_NOCaption; VOUCHER_NOCaptionLbl)
                {
                }
                column(CHEQUE_NOCaption; CHEQUE_NOCaptionLbl)
                {
                }
                column(PAYECaption; PAYECaptionLbl)
                {
                }
                column(PREPARED_BYCaption; PREPARED_BYCaptionLbl)
                {
                }
                column(CHECKED_BY_Caption; CHECKED_BY_CaptionLbl)
                {
                }
                column(SIGNATURECaption; SIGNATURECaptionLbl)
                {
                }
                column(DATE__________________________________________________Caption; DATE__________________________________________________CaptionLbl)
                {
                }
                column(PAYMENT_RECEIVED_BYCaption; PAYMENT_RECEIVED_BYCaptionLbl)
                {
                }
                column(SIGNATURE__________________________________________________Caption; SIGNATURE__________________________________________________CaptionLbl)
                {
                }
                column(DATE__________________________________________________Caption_Control1000000073; DATE__________________________________________________Caption_Control1000000073Lbl)
                {
                }
                column(APPROVALCaption; APPROVALCaptionLbl)
                {
                }
                column(SIGNATURECaption_Control1000000001; SIGNATURECaption_Control1000000001Lbl)
                {
                }
                column(DATE__________________________________________________Caption_Control1000000003; DATE__________________________________________________Caption_Control1000000003Lbl)
                {
                }
                column(APPROVED_BY_Caption; APPROVED_BY_CaptionLbl)
                {
                }
                column(SIGNATURE_Caption; SIGNATURE_CaptionLbl)
                {
                }
                column(DATE__________________________________________________Caption_Control1000000021; DATE__________________________________________________Caption_Control1000000021Lbl)
                {
                }
                column(Payecode; PAYECODE)
                {
                }
                column(WhtCode; WHTACC)
                {
                }
                column(ContactInfom; STRSUBSTNO(Text100, CompanyInfo."Phone No.", CompanyInfo."Phone No. 2", CompanyInfo."E-Mail", CompanyInfo."Home Page"))
                {
                }
                column(PaymentAccountNo; Payments."Account No.")
                {
                }
                column(TotalAmount; Payments."Total Amount")
                {
                }
                column(Remarks; "On behalf of")
                {
                }
                column(V4thapproverdate; "4thapproverdate")
                {
                }
                column(V4thapprover; "4thapprover")
                {
                }
                column(UserRecApp4_Picture; UserRecApp4.Picture)
                {
                }
                column(Designation_4; Designation4)
                {
                }
                column(V5thapproverdate; "5thapproverdate")
                {
                }
                column(V5thapprover; "5thapprover")
                {
                }
                column(UserRecApp5_Picture; UserRecApp5.Picture)
                {
                }
                column(Designation_5; Designation5)
                {
                }
                column(BankAccountNo; BankAccountNo)
                {
                }
                column(VBCCertLbl; VBCCertLbl)
                {
                }
                column(VBCCertText; VBCCertText)
                {
                }
                column(AIEHolderCertLbl; AIEHolderCertLbl)
                {
                }
                column(AIEHolderCertText; AIEHolderCertText)
                {
                }
                column(AuthorizationLbl; AuthorizationLbl)
                {
                }
                column(AuthorizationText1; AuthorizationText1)
                {
                }
                column(AuthorizationText2; AuthorizationText2)
                {
                }
                column(VoteLbl; VoteLbl)
                {
                }
                column(HeadLbl; HeadLbl)
                {
                }
                column(SubHeadLbl; SubHeadLbl)
                {
                }
                column(ItemLbl; ItemLbl)
                {
                }
                column(AIENoLbl; AIENoLbl)
                {
                }
                column(AccNoLbl; AccNoLbl)
                {
                }
                column(DeptVchLbl; DeptVchLbl)
                {
                }
                column(StationLbl; StationLbl)
                {
                }
                column(CshBkLbl; CshBkLbl)
                {
                }
                column(AmtLbl; AmtLbl)
                {
                }
                column(VchLbl; VchLbl)
                {
                }
                column(ShLbl; ShLbl)
                {
                }
                column(CtsLbl; CtsLbl)
                {
                }
                column(LPODescription; LPODescription)
                {
                }
                column(InvoiceNoLbl; InvoiceNo)
                {
                }
                column(AccountNameLbl; AccountNameLbl)
                {
                }
                column(FooterLbl; FooterLbl)
                {
                }
                column(RemarksLbl; RemarksLbl)
                {
                }
                column(AccountDesFootLbl; AccountDesFootLbl)
                {
                }
                column(PayeeLbl; PAYE)
                {
                }
                column(VATLbl; "W/VATAmount")
                {
                }
                column(WTaxLbl; WHTAmount)
                {
                }
                column(ChequeDateLbl; ChequeDateLbl)
                {
                }
                column(ChequeNoLbl; ChequeNoLbl)
                {
                }
                column(BankLbl; BankLbl)
                {
                }
                /*column(Budget;GLsetup.)
                {
                }*/
                column(PV_Lines1_AmountVote_; AccAmountVote)
                {
                }
                column(PV_Lines1__Account_No__1; AccNoVote)
                {
                }
                column(AccountName_PVLines2; AccNameVote)
                {
                }
                dataitem("PV Lines"; "PV Lines1")
                {
                    DataItemLink = No = FIELD ("No.");
                    DataItemTableView = SORTING (No, "Line No");
                    column(accno; accno)
                    {
                    }
                    column(accname; accname)
                    {
                    }
                    column(accname2; accname2)
                    {
                    }
                    column(PV_Lines1__Account_No__; "PV Lines"."Account No")
                    {
                    }
                    column(AccountName_PVLines1; "PV Lines".Description)
                    {
                    }
                    column(PV_Lines1_Description; Description)
                    {
                    }
                    column(PV_Lines1__Shortcut_Dimension_1_Code_; "Global Dimension 1 Code")
                    {
                    }
                    column(PV_Lines1__Account_Type_; "Account Type")
                    {
                    }
                    column(PV_Lines1__Shortcut_Dimension_2_Code_; "Global Dimension 2 Code")
                    {
                    }
                    column(STRSUBSTNO___1__2__CurrencyCodeText_Amount_; STRSUBSTNO('%1 %2', CurrencyCodeText, Amount))
                    {
                    }
                    column(PV_Lines1_AmountCaption; FIELDCAPTION(Amount))
                    {
                    }
                    column(PV_Lines1__Shortcut_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
                    {
                    }
                    column(PV_Lines1__Account_Type_Caption; FIELDCAPTION("Account Type"))
                    {
                    }
                    column(PV_Lines1__Account_No__Caption; FIELDCAPTION("Account No"))
                    {
                    }
                    column(PV_Lines1__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Global Dimension 2 Code"))
                    {
                    }
                    column(PV_Lines1_PV_No; No)
                    {
                    }
                    column(PV_Lines1_Line_No; "Line No")
                    {
                    }
                    column(PV_Lines1_Amount_; "PV Lines".Amount)
                    {
                    }
                    column(PV_Lines_VAT_Amount; "PV Lines"."VAT Amount")
                    {
                    }
                    column(PV_Lines_WTax_Amount; "PV Lines"."W/Tax Amount")
                    {
                    }
                    column(PV_Lines_Net_Amount; "PV Lines"."Net Amount")
                    {
                    }
                    column(WVATAmount; "W/VATAmount")
                    {
                    }
                    column(WTaxAmount; WHTAmount)
                    {
                    }
                    column(NetAmount; NetAmount)
                    {
                    }
                    column(PV_Lines1_Retention_Amount; "PV Lines"."Retention Amount")
                    {
                    }
                    column(PAYEE_Amount; "PV Lines".Amount)
                    {
                    }
                    column(RetentionAmount; RetentionAmount)
                    {
                    }
                    column(AppliestoDocNo_PVLines1; "PV Lines"."Applies to Doc. No")
                    {
                    }
                    column(AccountNo_PVLines1; "PV Lines"."Account No")
                    {
                    }
                    column(AccountType_PVLines1; "PV Lines"."Account Type")
                    {
                    }
                    column(PVAccountsNames; "PV Lines"."Account Name")
                    {
                    }
                    dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                    {
                        DataItemLink = "Document No." = FIELD ("Applies to Doc. No");
                    }
                
                trigger OnAfterGetRecord();
                begin
                    VATSetup.RESET;
                    VATSetup.SETRANGE(VATSetup."VAT Prod. Posting Group", "PV Lines"."VAT Code");
                    //VATSetup.SETRANGE(VATSetup."VAT Prod. Posting Group",'PAYE');
                    if VATSetup.FIND('-')
                      then begin
                        WHTACC := VATSetup."Purchase VAT Account";
                    end;

                    if "PV Lines"."Account Type" = "PV Lines"."Account Type"::Vendor then begin
                        if PostedInvoice.GET("PV Lines"."Applies to Doc. No") then
                            PostedInvoiceLines.RESET;
                        PostedInvoiceLines.SETRANGE("Document No.", PostedInvoice."No.");
                        if PostedInvoiceLines.FIND('-') then
                            GLAcc := PostedInvoiceLines."No.";
                    end;

                    if "PV Lines"."Account Type" = "PV Lines"."Account Type"::"G/L Account" then
                        GLAcc := "PV Lines"."Account No";

                    AccNoVote := '';
                    AccNameVote := '';
                    AccAmountVote := 0;
                    //=========================================================================================

                    /*accnotbl.RESET;
                    accnotbl.SETFILTER(accnotbl."Document No.", Payments."Claim No.");
                    if accnotbl.FINDSET then begin
                        //Message(accnotbl."Account No.");
                        accno := accnotbl."Account No.";
                        accname := accnotbl.Description;
                    end;*/

                    //========================================================================================
                    //*******Board*********LPO**********Claim**********//
                    if "PV Lines"."Applies to Doc. No" <> '' then begin
                        //Message('%1',PostedInvoiceLines."No.");
                        /*PostedInvoice.RESET;
                        PostedInvoice.SETRANGE(PostedInvoice."No.","PV Lines"."Applies to Doc. No");
                        IF PostedInvoice.FIND('-') THEN BEGIN*/

                        //  Message('%1',PostedInvoiceLines."No.");
                        PostedInvoiceLines.RESET;
                        PostedInvoiceLines.SETRANGE("Document No.", "PV Lines"."Applies to Doc. No");
                        if PostedInvoiceLines.FIND('+') then begin
                            AccAmountVote := PostedInvoiceLines.Amount;

                            if PostedInvoiceLines.Type = PostedInvoiceLines.Type::"G/L Account" then begin
                                AccNoVote := PostedInvoiceLines."No.";
                                if GLAccount.GET(PostedInvoiceLines."No.") then
                                    AccNameVote := GLAccount.Name;
                            end;

                            if PostedInvoiceLines.Type = PostedInvoiceLines.Type::Item then begin
                                GenPostingSetup.RESET;
                                GenPostingSetup.SETRANGE(GenPostingSetup."Gen. Bus. Posting Group", '');
                                GenPostingSetup.SETRANGE(GenPostingSetup."Gen. Prod. Posting Group", PostedInvoiceLines."Gen. Prod. Posting Group");
                                if GenPostingSetup.FIND('-') then
                                    AccNoVote := GenPostingSetup."Inventory Adjmt. Account";
                                if GLAccount.GET(GenPostingSetup."Inventory Adjmt. Account") then
                                    AccNameVote := GLAccount.Name;
                            end;

                            if PostedInvoiceLines.Type = PostedInvoiceLines.Type::"Fixed Asset" then begin
                                FADepreciation.RESET;
                                FADepreciation.SETRANGE(FADepreciation."FA No.", PostedInvoiceLines."No.");
                                if FADepreciation.FIND('-') then
                                    if FAPostingGp.GET(FADepreciation."FA Posting Group") then
                                        AccNoVote := FAPostingGp."Acquisition Cost Account";
                                if GLAccount.GET(FAPostingGp."Acquisition Cost Account") then
                                    AccNameVote := GLAccount.Name;
                            end;


                            //END;
                        end;

                        //Board and Claims PV

                        if BoardPV.GET("PV Lines"."Applies to Doc. No") then begin
                            BoardPVLines.RESET;
                            BoardPVLines.SETRANGE(BoardPVLines.No, BoardPV."No.");
                            BoardPVLines.SETRANGE(BoardPVLines.Amount, "PV Lines".Amount);
                            if BoardPVLines.FIND('-') then begin
                                AccNoVote := BoardPVLines."Account No";
                                AccNameVote := BoardPVLines."Account Name";
                                AccAmountVote := BoardPVLines.Amount;
                            end;

                        end;

                    end else begin// //*******Board*********LPO**********Claim**********//
                                  //Message(format(AccNoVote));
                        AccNoVote := "PV Lines"."Account No";
                        AccNameVote := "PV Lines"."Account Name";
                        AccAmountVote := "PV Lines".Amount;

                    end;

                    //=========================================================================
                    if accno = '' then begin
                        accno := "PV Lines"."Account No";
                        accname := "PV Lines".Description;
                        accname2 := "PV Lines"."Account Name";
                    end;
                    //==========================================================================

                end;
            }

            trigger OnAfterGetRecord();
            var
                PVLines: Record "PV Lines1";
            begin


                DimValues.RESET;
                DimValues.SETRANGE(DimValues."Dimension Code", 'BRANCHES');
                DimValues.SETRANGE(DimValues.Code, Payments."Global Dimension 1 Code");

                if DimValues.FIND('-') then begin
                    CompName := DimValues.Name;
                end
                else begin
                    CompName := '';
                end;

                if Payments.Currency <> '' then
                    CurrencyCodeText := Payments.Currency
                else
                    CurrencyCodeText := GLsetup."LCY Code";
                Payments.CALCFIELDS("Total Amount");
                InitTextVariable;
                FormatNoText(NumberText, "Total Amount", '');

                Banks.RESET;
                Banks.SETRANGE(Banks."No.", Payments."Paying Bank Account");
                if Banks.FIND('-') then begin
                    BankName := Banks.Name;
                end
                else begin
                    BankName := '';
                end;

                Bank.RESET;
                Bank.SETRANGE(Bank."No.", Payments."Paying Bank Account");
                if Bank.FIND('-') then begin
                    PayeeBankName := Bank.Name;
                    BankAccountNo := Bank."Bank Account No.";
                end
                else begin
                    PayeeBankName := '';
                end;

                PGAccount := '';

                if Payments."Account Type" = Payments."Account Type"::"G/L Account" then begin
                    PGAccount := Payments."Account No.";
                end;

                if Payments."Account Type" = Payments."Account Type"::"Bank Account" then begin
                    Bank.RESET;
                    Bank.SETRANGE(Bank."No.", Payments."Account No.");
                    if Bank.FIND('-') then begin
                        Bank.TESTFIELD(Bank."Bank Acc. Posting Group");
                        BankPG.RESET;
                        BankPG.SETRANGE(BankPG.Code, Bank."Bank Acc. Posting Group");
                        if BankPG.FIND('-') then begin
                            PGAccount := BankPG."G/L Bank Account No.";
                        end;
                    end;
                end;

                if Payments."Account Type" = Payments."Account Type"::Vendor then begin
                    Vend.RESET;
                    Vend.SETRANGE(Vend."No.", Payments."Account No.");
                    if Vend.FIND('-') then begin
                        Vend.TESTFIELD(Vend."Vendor Posting Group");
                        VendorPG.RESET;
                        VendorPG.SETRANGE(VendorPG.Code, Vend."Vendor Posting Group");
                        if VendorPG.FIND('-') then begin
                            PGAccount := VendorPG."Payables Account";
                        end;
                    end;
                end;

                if Payments."Account Type" = Payments."Account Type"::Customer
                  then begin
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.", Payments."Account No.");
                    if Cust.FIND('-')
                      then begin
                        Cust.TESTFIELD(Cust."Customer Posting Group");
                        CustPG.RESET;
                        CustPG.SETRANGE(CustPG.Code, Cust."Customer Posting Group");
                        if CustPG.FIND('-')
                          then begin
                            PGAccount := CustPG."Receivables Account";

                        end;
                    end;
                end;

                if Payments."Account Type" = Payments."Account Type"::"Fixed Asset" then begin
                    FA.RESET;
                    FA.SETRANGE(FA."FA No.", Payments."Account No.");
                    if FA.FIND('-') then begin
                        FA.TESTFIELD(FA."FA Posting Group");
                        FAPG.RESET;
                        FAPG.SETRANGE(FAPG.Code, FA."FA Posting Group");
                        if FAPG.FIND('-') then begin
                            PGAccount := FAPG."Acquisition Cost Account";
                        end;
                    end;
                end;

                BankAccountUsed := '';
                //Payments.TESTFIELD(Payments."Pay Mode");
                if Payments."Pay Mode" = 'CASH' then begin
                    BankAccountUsed := Payments."Paying Bank Account";
                end
                else begin
                    BankAccountUsed := Payments."Paying Bank Account";
                end;

                BankAccountUsedName := '';
                Bank.RESET;
                Bank.SETRANGE(Bank."No.", BankAccountUsed);
                if Bank.FIND('-') then begin
                    Bank.TESTFIELD(Bank."Bank Acc. Posting Group");
                    BankPG.RESET;
                    BankPG.SETRANGE(BankPG.Code, Bank."Bank Acc. Posting Group");
                    if BankPG.FIND('-') then begin
                        BankAccountUsed := BankPG."G/L Bank Account No.";
                    end;
                    //BankAccountUsedName:=Bank.Name;
                end;

                GLAccount.RESET;
                GLAccount.SETRANGE(GLAccount."No.", BankAccountUsed);
                if GLAccount.FIND('-') then begin
                    BankAccountUsedName := GLAccount.Name;
                end;


                PGAccountUsedName := '';
                GLAccount.RESET;
                GLAccount.SETRANGE(GLAccount."No.", PGAccount);
                if GLAccount.FIND('-') then begin
                    PGAccountUsedName := GLAccount.Name;
                end;
                /* IF UserRec.GET(Payments.Cashier) THEN
                 BEGIN
                 //MESSAGE('%1',Payments.Cashier);
                 UserRec.CALCFIELDS(UserRec.Picture);
                 END;*/


                //Get Signatures from the Imprest Table****End
                /*
                if ReqHeader.GET(Payments."No.") then begin

                    ApprovalEntries.RESET;
                    ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 51513126);
                    ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", ReqHeader."No.");
                    ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                    if ApprovalEntries.FIND('-') then begin
                        i := 0;
                        repeat
                            i := i + 1;
                            if i = 1 then begin
                                "1stapprover" := ApprovalEntries."Sender ID";
                                "1stapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp1.GET("1stapprover") then begin
                                    UserRecApp1.CALCFIELDS(UserRecApp1.Picture);
                                end;
                                MESSAGE("1stapprover");

                                "2ndapprover" := ApprovalEntries."Approver ID";
                                "2ndapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp2.GET("2ndapprover") then begin
                                    UserRecApp2.CALCFIELDS(UserRecApp2.Picture);
                                end;
                            end;
                            MESSAGE("2ndapprover");
                            if i = 2 then begin
                                "3rdapprover" := ApprovalEntries."Approver ID";
                                "3rdapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp3.GET("3rdapprover") then begin
                                    UserRecApp3.CALCFIELDS(UserRecApp3.Picture);
                                end;

                                if i = 3 then begin
                                    "4thapprover" := ApprovalEntries."Approver ID";
                                    "4thapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                    if UserRecApp4.GET("4thapprover") then
                                        UserRecApp4.CALCFIELDS(UserRecApp4.Picture);

                                end;



                            end;

                        until ApprovalEntries.NEXT = 0;
                    end;
                end;
                */
                //Get Signatures from the Imprest Table****End



                //Get Signatures from the Claim Table****End
                /*
                if RequestHeader.GET(Payments."Claim No.") then begin

                    ApprovalEntries.RESET;
                    ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 51511706);
                    ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", RequestHeader."No.");
                    ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                    if ApprovalEntries.FIND('-') then begin
                        i := 0;
                        repeat
                            i := i + 1;
                            if i = 1 then begin
                                "1stapprover" := ApprovalEntries."Sender ID";
                                "1stapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp1.GET("1stapprover") then begin
                                    UserRecApp1.CALCFIELDS(UserRecApp1.Picture);
                                end;




                                "2ndapprover" := ApprovalEntries."Approver ID";
                                "2ndapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp2.GET("2ndapprover") then begin
                                    UserRecApp2.CALCFIELDS(UserRecApp2.Picture);
                                end
                            end;

                            if i = 2 then begin
                                "3rdapprover" := ApprovalEntries."Approver ID";
                                "3rdapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp3.GET("3rdapprover") then begin
                                    UserRecApp3.CALCFIELDS(UserRecApp3.Picture);
                                end;

                                if i = 4 then begin
                                    "4thapprover" := ApprovalEntries."Approver ID";
                                    "4thapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                    if UserRecApp4.GET("4thapprover") then
                                        UserRecApp4.CALCFIELDS(UserRecApp4.Picture);

                                end;



                            end;

                        until ApprovalEntries.NEXT = 0;
                    end;
                end;
                */
                //Get Signatures from the Claim Table****End



                //Board Payments Signatures
                /*
                                if PV.GET(Payments."Bord PV No") then begin
                                    ApprovalEntries.RESET;
                                    ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 51511003);
                                    ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", PV.No);
                                    ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                                    TotalApprovals := ApprovalEntries.COUNT;
                                    if ApprovalEntries.FIND('-') then begin
                                        i := 0;
                                        repeat
                                            i := i + 1;
                                            if i = 1 then begin
                                                "1stapprover" := ApprovalEntries."Sender ID";
                                                "1stapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                                if UserRecApp1.GET("1stapprover") then
                                                    UserRecApp1.CALCFIELDS(UserRecApp1.Picture);



                                                "2ndapprover" := ApprovalEntries."Approver ID";
                                                "2ndapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                                if UserRecApp2.GET("2ndapprover") then
                                                    UserRecApp2.CALCFIELDS(UserRecApp2.Picture);

                                            end;

                                            if i = 2 then begin
                                                "3rdapprover" := ApprovalEntries."Approver ID";
                                                "3rdapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                                if UserRecApp3.GET("3rdapprover") then
                                                    UserRecApp3.CALCFIELDS(UserRecApp3.Picture);

                                            end;

                                            if i = 3 then begin
                                                "4thapprover" := ApprovalEntries."Approver ID";
                                                "4thapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                                if UserRecApp4.GET("4thapprover") then
                                                    UserRecApp4.CALCFIELDS(UserRecApp4.Picture);

                                            end;


                                        until ApprovalEntries.NEXT = 0;
                                    end;


                                end;
                                */
                //Board Payments Signatures****End




                ApprovalEntries.RESET;
                ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 51513031);
                ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", Payments."No.");
                ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                TotalApprovals := ApprovalEntries.COUNT;
                if ApprovalEntries.FIND('-') then begin
                    i := 0;
                    repeat
                        i := i + 1;
                        if i = 1 then begin
                            "1stapprover" := ApprovalEntries."Sender ID";
                            "1stapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp1.GET("1stapprover") then
                                UserRecApp1.CALCFIELDS(UserRecApp1.Picture);




                            "2ndapprover" := ApprovalEntries."Approver ID";
                            "2ndapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp2.GET("2ndapprover") then
                                UserRecApp2.CALCFIELDS(UserRecApp2.Picture);

                        end;

                        if i = 2 then begin
                            "3rdapprover" := ApprovalEntries."Approver ID";
                            "3rdapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp3.GET("3rdapprover") then
                                UserRecApp3.CALCFIELDS(UserRecApp3.Picture);
                        end;

                        if i = 3 then begin
                            "4thapprover" := ApprovalEntries."Approver ID";
                            "4thapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp4.GET("4thapprover") then
                                UserRecApp4.CALCFIELDS(UserRecApp4.Picture);

                        end;


                    until ApprovalEntries.NEXT = 0;
                end;

            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
            end;
        }
    }
    }
    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        SerialNo = 'PV NO'; PayeeLabel = 'PAYEE:'; Particulars = 'Particulars'; LpoNo = 'LPO/Description'; InvoiceNo = 'Invoice No.'; AmountLabel = 'AMOUNT'; AmountsInwords = 'Amount Payable (in words)'; AuthorizedBy = 'Approved by:'; Naration = 'I Certify that, the Invoice(s) above are for incured expendirue and authorized purpose'; Total = 'TOTAL Ksh.'; Dr = 'AC (Dr)'; Cr = 'AC (Cr)'; Designation = 'Designation'; Sign = 'Signature'; ChequeNo = 'Cheque No:'; AccountNo = 'Account #:'; Description = 'Description:'; QTY = 'QTY'; UNITCOST = 'UNIT COST'; TotalCost = 'TOTAL COST'; Date = 'Date:'; Accountant = 'Accountant i/c VBC/EXAMINATION'; FM = 'Finance Manager'; DDFM = 'Deputy Director Finance'; DFM = 'DIRECTOR GENERAL/DF&A'; Receipient = 'Received By:'; ID = 'ID Number:'; Footer = 'THANK YOU FOR YOUR VALUED SERVICES'; SAccountant = '/CHIEF ACCOUNTANT'; DVC = 'DVC FAP'; RecommendedBy = 'Recommended by:'; Name = 'Name';
    }

    trigger OnPreReport();
    begin
        CompanyInfo.GET;
        SalesSetup.GET;
        GLsetup.GET;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo.GET;
                    CompanyInfo.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo.GET;
                    CompanyInfo.CALCFIELDS(Picture);
                end;
        end;
    end;

    var
        PreparedbyName: Text[100];
        AuthorizedName: Text[100];
        DimValues: Record "Dimension Value";
        CompName: Text[100];
        TypeOfDoc: Text[100];
        // RecPayTypes: Record Receipts;
        BankName: Text[100];
        Banks: Record "Bank Account";
        Bank: Record "Bank Account";
        PayeeBankName: Text[100];
        VendorPG: Record "Vendor Posting Group";
        CustPG: Record "Customer Posting Group";
        FAPG: Record "FA Posting Group";
        BankPG: Record "Bank Account Posting Group";
        PGAccount: Text[50];
        Vend: Record Vendor;
        Cust: Record Customer;
        FA: Record "FA Depreciation Book";
        BankAccountUsed: Text[50];
        BankAccountUsedName: Text[100];
        PGAccountUsedName: Text[50];
        GLAccount: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        GLsetup: Record "General Ledger Setup";
        NumberText: array[2] of Text[80];
        CurrencyCodeText: Code[10];
        TXT001: Label '%1 %2';
        TXT002: Label '%1 %2 - %3';
        ApprovalEntries: Record "Approval Entry";
        "1stapprover": Text[30];
        "2ndapprover": Text[30];
        i: Integer;
        "1stapproverdate": DateTime;
        "2ndapproverdate": DateTime;
        UserRec: Record "User Setup";
        UserRecApp1: Record "User Setup";
        UserRecApp2: Record "User Setup";
        UserRecApp3: Record "User Setup";
        "3rdapprover": Text[30];
        "3rdapproverdate": DateTime;
        PAYMENT_VOUCHERCaptionLbl: Label 'PAYMENT VOUCHER';
        BANK_NAMECaptionLbl: Label 'BANK NAME';
        VOUCHER_NOCaptionLbl: Label 'VOUCHER NO';
        CHEQUE_NOCaptionLbl: Label 'CHEQUE NO';
        PAYECaptionLbl: Label 'PAYE';
        PREPARED_BYCaptionLbl: Label 'Prepared / Examined by:';
        CHECKED_BY_CaptionLbl: Label 'Authorized by:';
        SIGNATURECaptionLbl: Label 'Signature____________________';
        DATE__________________________________________________CaptionLbl: Label 'Date________________';
        PAYMENT_RECEIVED_BYCaptionLbl: Label 'PAYMENT RECEIVED BY';
        SIGNATURE__________________________________________________CaptionLbl: Label 'Signature____________________';
        DATE__________________________________________________Caption_Control1000000073Lbl: Label 'Date________________';
        APPROVALCaptionLbl: Label 'APPROVAL';
        SIGNATURECaption_Control1000000001Lbl: Label 'Signature____________________';
        DATE__________________________________________________Caption_Control1000000003Lbl: Label 'Date________________';
        APPROVED_BY_CaptionLbl: Label 'Approved by';
        SIGNATURE_CaptionLbl: Label 'Signature____________________';
        DATE__________________________________________________Caption_Control1000000021Lbl: Label 'Date________________';
        PAYE: Label 'PAYE';
        "W/VATAmount": Label 'W/VAT Amount';
        WHTAmount: Label 'WHT Amount';
        NetAmount: Label 'Net Amount';
        RetentionAmount: Label 'Retention Amount';
        PayeeAddress: Text[250];
        OrderNo: Code[50];
        PostedInvoice: Record "Purch. Inv. Header";
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label '" is already applied to %1 %2 for customer %3."';
        Text031: Label '" is already applied to %1 %2 for vendor %3."';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        PostedInvoiceLines: Record "Purch. Inv. Line";
        ApprovalName: Text;
        UserSetup: Record User;
        Designation1: Text[50];
        Designation2: Text[50];
        Designation3: Text[50];
        VATSetup: Record "VAT Posting Setup";
        WHTACC: Code[20];
        PAYECODE: Code[20];
        EmpRec: Record Employee;
        Text100: Label '" %1 | %2 | Mobile Phone: %3 | Email: %4 | Website: %5 | PIN No: %6"';
        UserRecApp4: Record "User Setup";
        "4thapprover": Text[30];
        "4thapproverdate": DateTime;
        Designation4: Text[50];
        BankAccountNo: Code[20];
        TotalApprovals: Integer;
        UserRecApp5: Record "User Setup";
        "5thapprover": Text[30];
        Designation5: Text[50];
        "5thapproverdate": DateTime;
        VBCCertLbl: Label 'PREPARATION/VBC/EXAMINATION';
        VBCCertText: Label 'I certify that the expenditure has been entered in the vote book and that adequate funds to cover it are available against the chargeable items as shown here below';
        AIEHolderCertLbl: Label 'A.I.E HOLDER CERTIFICATE';
        AIEHolderCertText: Label 'I certify that the expenditure detailed above has been incurrred for the authorized purpose and should be charged to the item shown here below';
        AuthorizationLbl: Label 'AUTHORIZATION';
        AuthorizationText1: Label 'I certify that the rate/price charged is/are according to regulations/contract, fair and reasonable that the expenditure has been incurred on proper authority and should be charged as under. Where appropriate a certificate overleaf has been completed.';
        AuthorizationText2: Label 'I hereby authorize payment of the amount shown above without any alteration.';
        EstimatesAllocationLbl: Label 'Approved Estimates/Allocation';
        InternalAuditLbl: Label 'INTERNAL AUDIT';
        LPODescription: Label 'LPO/Description';
        InvoiceNo: Label 'Invoice No.';
        VoteLbl: Label 'Vote';
        HeadLbl: Label 'Head';
        SubHeadLbl: Label 'Sub-Head';
        ItemLbl: Label 'Item';
        AIENoLbl: Label 'A.I.E No.';
        AccNoLbl: Label 'Account No.';
        DeptVchLbl: Label 'Dept. Vch.';
        StationLbl: Label 'Station';
        CshBkLbl: Label 'CASH BOOK';
        AmtLbl: Label 'AMOUNT';
        VchLbl: Label 'Vch.';
        ShLbl: Label 'Sh.';
        CtsLbl: Label 'Cts.';
        FooterLbl: Label '"""Our Environment | Our Life | Our Responsibility"""';
        RemarksLbl: Label 'Remarks';
        AccountDesFootLbl: Label 'Account Description';
        AccountNameLbl: Label 'Account Name';
        ChequeDateLbl: Label 'Cheque/EFT Date';
        ChequeNoLbl: Label 'Cheque No/EFT No';
        BankLbl: Label 'Bank:';
        //RequestHeader: Record "Request Header";
        //ReqHeader: Record "Request Header";
        //ImpReqReport: Report "Imprest-Claim Voucher";
        PV: Record "Payments HeaderFin";
        GLAcc: Code[40];
        AccNoVote: Code[50];
        AccNameVote: Code[50];
        AccAmountVote: Decimal;
        GenPostingSetup: Record "General Posting Setup";
        FAPostingGp: Record "FA Posting Group";
        FADepreciation: Record "FA Depreciation Book";
        BoardPV: Record "Payments HeaderFin";
        BoardPVLines: Record "PV Lines1";
        //accnotbl: Record "Cash Request Lines";
        accno: Text;
        accname: Text;
        accname2: Text;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div POWER(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            end;
        end;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        AddToNoText(NoText, NoTextIndex, PrintExponent, FORMAT(No * 100) + ' Cents');

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, '');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30]);
    begin
        PrintExponent := true;

        while STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ARRAYLEN(NoText) then
                ERROR(Text029, AddText);
        end;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable();
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;
}

