report 51513001 "Petty Cash Voucher"
{
    // version FINANCE

    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Petty Cash Voucher.rdl';
    Caption = 'Petty Cash Voucher';


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

            dataitem("Payments HeaderFin"; "Payments HeaderFin")
            {
                DataItemTableView = SORTING ("No.");
                RequestFilterFields = "No.";
                column(CompanyInfo_Name__; CompanyInfo.Name)
                {
                }
                column(STRSUBSTNO_TXT002_CompanyInfo_Address_CompanyInfo__Post_Code__CompanyInfo_City_; STRSUBSTNO(TXT002, CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo.City, CompanyInfo."Post Code", CompanyInfo.City))
                {
                }
                column(ContactInfo; STRSUBSTNO(Text100, CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo."Phone No.", CompanyInfo."E-Mail", CompanyInfo."Home Page"))
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(Request_Header1__No__; "No.")
                {
                }
                column(Request_Header1__Request_Date_; Date)
                {
                }

                column(NumberText_1_; NumberText[1])
                {
                }
                column(NumberText_2_; NumberText[2])
                {
                }
                column(CompName; CompName)
                {
                }

                column(BankAccount_RequestHeader1; "Payments HeaderFin"."Paying Bank Account")
                {
                }

                column(ImprestAmount_RequestHeader1; "Payments HeaderFin".Payee)
                {
                }
                column(TotalAmountRequested_RequestHeader1; "Payments HeaderFin"."Petty Cash Amount")
                {
                }
                column(ChequeNo_RequestHeader1; "Payments HeaderFin"."Cheque No")
                {
                }
                column(ChequeDate_RequestHeader1; "Payments HeaderFin"."Cheque Date")
                {
                }
                column(PayMode_RequestHeader1; "Payments HeaderFin"."Pay Mode")
                {
                }


                column(IMPREST_CLAIM_FORMCaption; Headertxt)
                {
                }
                column(Request_Header1__No__Caption; IAFNoLbl)
                {
                }
                column(Request_Header1__Request_Date_Caption; FIELDCAPTION(Date))
                {
                }
                column(Request_Header1__Employee_Name_Caption; FIELDCAPTION(Payee))
                {
                }
                column(Department_Caption; Department_CaptionLbl)
                {
                }
                column(AccNoLbl; AccNoLbl)
                {
                }
                column(AccountDesFootLbl; AccountDesFootLbl)
                {
                }
                column(AccountNameLbl; AccountNameLbl)
                {
                }
                column(AmtLbl; AmtLbl)
                {
                }
                column(DepartmentName; DepartmentName)
                {
                }
                column(JobTitle; JobTitle)
                {
                }
                column(LESSADVANCEAMOUNT; LESSADVANCEAMOUNT)
                {
                }
                column(Amountdue; Amountdue)
                {
                }
                column(impamount; Impamount)
                {
                }
                column(TOTALDUE; TOTALDUE)
                {
                }
                column(Impamount2; Impamount2)
                {
                }
                dataitem("Request Lines"; "Petty Cash Lines")
                {
                    DataItemLink = No = FIELD ("No.");
                    DataItemTableView = SORTING ("No", "Line No");
                    column(Request_Lines1_Description; Description)
                    {
                    }
                    column(RequestAmount; "Request Lines".Amount)
                    {
                    }
                    column(Account_No; "Account No")
                    {
                    }
                    column(STRSUBSTNO___1__2__CurrencyCodeText__Request_Lines1___Requested_Amount__; STRSUBSTNO('%1 %2', CurrencyCodeText, "Request Lines".Amount))
                    {
                    }

                    column(STRSUBSTNO___1__2__CurrencyCodeText_Netamt_; STRSUBSTNO('%1 %2', CurrencyCodeText, Netamt))
                    {
                    }
                    column(EmptyString; '____________________')
                    {
                    }
                    column(UserRecApp3_Picture; UserRecApp3.Picture)
                    {
                    }
                    column(V3rdapproverdate_; "3rdapproverdate")
                    {
                    }
                    column(V3rdapprover_; "3rdapprover")
                    {
                    }
                    column(UserRecApp2_Picture; UserRecApp2.Picture)
                    {
                    }
                    column(V2ndapprover_; "2ndapprover")
                    {
                    }
                    column(V2ndapproverdate_; "2ndapproverdate")
                    {
                    }
                    column(V1stapprover_; "1stapprover")
                    {
                    }
                    column(UserRecApp1_Picture; UserRecApp1.Picture)
                    {
                    }
                    column(V1stapproverdate_; "1stapproverdate")
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(Request_Lines1__Account_No_Caption; FIELDCAPTION("Account No"))
                    {
                    }
                    column(TOTAL_EXPENSESCaption; TOTAL_EXPENSESCaptionLbl)
                    {
                    }
                    column(LESS__ADVANCECaption; LESS__ADVANCECaptionLbl)
                    {
                    }
                    column(AMOUNT_DUE_TO__FROM__EMPLOYEECaption; AMOUNT_DUE_TO__FROM__EMPLOYEECaptionLbl)
                    {
                    }
                    column(PAYMENT_RECEIVED_BYCaption; PAYMENT_RECEIVED_BYCaptionLbl)
                    {
                    }
                    column(SIGNATURE__________________________________________________Caption; SIGNATURE__________________________________________________CaptionLbl)
                    {
                    }
                    column(DATE__________________________________________________Caption; DATE__________________________________________________CaptionLbl)
                    {
                    }
                    column(APPROVED_BY_Caption; APPROVED_BY_CaptionLbl)
                    {
                    }
                    column(SIGNATURE_Caption; SIGNATURE_CaptionLbl)
                    {
                    }
                    column(DATE__________________________________________________Caption_Control1000000036; DATE__________________________________________________Caption_Control1000000036Lbl)
                    {
                    }
                    column(CHECKED_BY_Caption; CHECKED_BY_CaptionLbl)
                    {
                    }
                    column(SIGNATURECaption; SIGNATURECaptionLbl)
                    {
                    }
                    column(DATE__________________________________________________Caption_Control1000000042; DATE__________________________________________________Caption_Control1000000042Lbl)
                    {
                    }
                    column(PREPARED_BYCaption; PREPARED_BYCaptionLbl)
                    {
                    }
                    column(SIGNATURECaption_Control1000000055; SIGNATURECaption_Control1000000055Lbl)
                    {
                    }
                    column(DATE__________________________________________________Caption_Control1000000062; DATE__________________________________________________Caption_Control1000000062Lbl)
                    {
                    }
                    column(APPROVALCaption; APPROVALCaptionLbl)
                    {
                    }
                    column(Request_Lines1_Document_No; No)
                    {
                    }
                    column(Request_Lines1_Line_No_; "Line No")
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

                    column(ImprestDetailsLbl; ImprestDetailsLbl)
                    {
                    }
                    column(DesignationLbl; DesignationLbl)
                    {
                    }
                    column(AccountType; "Request Lines"."Account Type")
                    {
                    }
                    column(TransactionType; "Request Lines"."Transaction Type")
                    {
                    }
                    column(Account_Name; "Request Lines"."Account Name")
                    {
                    }
                    column(AccountNo; "Request Lines"."Account No")
                    {
                    }
                    column(Amnt; "Request Lines".Amount)
                    {
                    }
                    column(AccDescription; "Request Lines".Description)
                    {
                    }
                    column(RemarksLbl; RemarksLbl)
                    {
                    }
                    column(VoteLbl; VoteLbl)
                    {
                    }
                    column(FooterLbl; FooterLbl)
                    {
                    }
                    column(Jobtitle_1; Jobtitle1)
                    {
                    }
                    column(Jobtitle_2; Jobtitle2)
                    {
                    }
                    column(Jobtitle_3; Jobtitle3)
                    {
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    /*
                    Netamt := 0;

                    CompanyInfo.GET;
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                    if Emp.GET("Request Header"."Employee No") then begin
                        dimvalue.RESET;
                        dimvalue.SETFILTER("Dimension Code", 'DEPARTMENT');
                        dimvalue.SETFILTER(Code, Emp."Global Dimension 1 Code");
                        if dimvalue.FINDSET then begin
                            DepartmentName := dimvalue.Name;
                            JobTitle := Emp."Job Title";
                        end;
                    end;

                    IF Cust.GET("Request Header"."Customer A/C") THEN BEGIN
                       CustName:=Cust.Name; Cust.CALCFIELDS(Balance); LESSADVANCEAMOUNT:=Cust.Balance;
                       requestlines.RESET;
                       requestlines.SETFILTER("Document No","Request Header"."No.");
                       IF requestlines.FINDSET THEN REPEAT
                          TOTALDUE:=TOTALDUE+requestlines.Amount;
                       UNTIL requestlines.NEXT=0;
                         TOTALDUE:=TOTALDUE+LESSADVANCEAMOUNT;

                    END;

                    DimValues.RESET;
                    DimValues.SETRANGE(DimValues."Dimension Code", 'DEPARTMENT');
                    DimValues.SETRANGE(DimValues.Code, "Request Header"."Global Dimension 1 Code");

                    if DimValues.FIND('-') then begin
                        CompName := DimValues.Name;
                    end

                    else begin
                        CompName := '';
                    end;

                    IF Payments.Currency<>'' THEN
                    CurrencyCodeText:=Payments.Currency
                    ELSE
                    CurrencyCodeText := GLsetup."LCY Code";

                    /*Banks.RESET;
                    Banks.SETRANGE(Banks."No.",Payments."KBA Bank Code");
                    IF Banks.FIND('-') THEN BEGIN
                    BankName:=Banks.Name;
                    END
                    ELSE BEGIN
                    BankName:='';
                    END;

                    Bank.RESET;
                    Bank.SETRANGE(Bank."No.",Payments."Paying Bank Account");
                    IF Bank.FIND('-') THEN BEGIN
                    PayeeBankName:=Bank.Name;
                    END
                    ELSE BEGIN
                    PayeeBankName:='';
                    END;

                    PGAccount:='';

                    IF Payments."Account Type"=Payments."Account Type"::"G/L Account" THEN BEGIN
                    PGAccount:=Payments."Account No.";
                    END;

                    IF Payments."Account Type"=Payments."Account Type"::"Bank Account" THEN BEGIN
                    Bank.RESET;
                    Bank.SETRANGE(Bank."No.",Payments."Account No.");
                    IF Bank.FIND('-') THEN BEGIN
                    Bank.TESTFIELD(Bank."Bank Acc. Posting Group");
                    BankPG.RESET;
                    BankPG.SETRANGE(BankPG.Code,Bank."Bank Acc. Posting Group");
                    IF BankPG.FIND('-') THEN BEGIN
                    PGAccount:=BankPG."G/L Bank Account No.";
                    END;
                    END;
                    END;

                    IF Payments."Account Type"=Payments."Account Type"::Vendor THEN BEGIN
                    Vend.RESET;
                    Vend.SETRANGE(Vend."No.",Payments."Account No.");
                    IF Vend.FIND('-') THEN BEGIN
                    Vend.TESTFIELD(Vend."Vendor Posting Group");
                    VendorPG.RESET;
                    VendorPG.SETRANGE(VendorPG.Code,Vend."Vendor Posting Group");
                    IF VendorPG.FIND('-') THEN BEGIN
                    PGAccount:=VendorPG."Payables Account";
                    END;
                    END;
                    END;

                    IF Payments."Account Type"=Payments."Account Type"::Customer THEN BEGIN
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.",Payments."Account No.");
                    IF Cust.FIND('-') THEN BEGIN
                    Cust.TESTFIELD(Cust."Customer Posting Group");
                    CustPG.RESET;
                    CustPG.SETRANGE(CustPG.Code,Cust."Customer Posting Group");
                    IF CustPG.FIND('-') THEN BEGIN
                    PGAccount:=CustPG."Receivables Account";
                    END;
                    END;
                    END;

                    IF Payments."Account Type"=Payments."Account Type"::"Fixed Asset" THEN BEGIN
                    FA.RESET;
                    FA.SETRANGE(FA."FA No.",Payments."Account No.");
                    IF FA.FIND('-') THEN BEGIN
                    FA.TESTFIELD(FA."FA Posting Group");
                    FAPG.RESET;
                    FAPG.SETRANGE(FAPG.Code,FA."FA Posting Group");
                    IF FAPG.FIND('-') THEN BEGIN
                    PGAccount:=FAPG."Acquisition Cost Account";
                    END;
                    END;
                    END;

                    BankAccountUsed:='';
                    //Payments.TESTFIELD(Payments."Pay Mode");
                    IF Payments."Pay Mode"='CASH' THEN BEGIN
                    BankAccountUsed:=Payments."Cashier Bank Account";
                    END
                    ELSE BEGIN
                    BankAccountUsed:=Payments."Paying Bank Account";
                    END;

                    BankAccountUsedName:='';
                    Bank.RESET;
                    Bank.SETRANGE(Bank."No.",BankAccountUsed);
                    IF Bank.FIND('-') THEN BEGIN
                    Bank.TESTFIELD(Bank."Bank Acc. Posting Group");
                    BankPG.RESET;
                    BankPG.SETRANGE(BankPG.Code,Bank."Bank Acc. Posting Group");
                    IF BankPG.FIND('-') THEN BEGIN
                    BankAccountUsed:=BankPG."G/L Bank Account No.";
                    END;
                    //BankAccountUsedName:=Bank.Name;
                    END;

                    GLAccount.RESET;
                    GLAccount.SETRANGE(GLAccount."No.",BankAccountUsed);
                    IF GLAccount.FIND('-') THEN BEGIN
                    BankAccountUsedName:=GLAccount.Name;
                    END;


                    PGAccountUsedName:='';
                    GLAccount.RESET;
                    GLAccount.SETRANGE(GLAccount."No.",PGAccount);
                    IF GLAccount.FIND('-') THEN BEGIN
                    PGAccountUsedName:=GLAccount.Name;
                    END;
                    { IF UserRec.GET(Payments.Cashier) THEN
                     BEGIN
                     //MESSAGE('%1',Payments.Cashier);
                     UserRec.CALCFIELDS(UserRec.Picture);
                     END;} 

                    if "Request Header"."Request Date" < 20171007D
                     then begin

                        ApprovalEntries.RESET;
                        ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 51511126);
                        ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", "Request Header"."No.");
                        ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                        if ApprovalEntries.FIND('-') then begin
                            i := 0;
                            repeat
                                i := i + 1;//MESSAGE('%1..%2',i,ApprovalEntries."Approver ID");
                                if i = 1 then begin
                                    "1stapprover" := ApprovalEntries."Sender ID";
                                    "1stapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                    if UserRecApp1.GET("1stapprover") then begin
                                        UserRecApp1.CALCFIELDS(UserRecApp1.Picture);
                                        if Emp.GET(UserRecApp1."Employee No.") then
                                            Jobtitle1 := Emp."Job Title";
                                    end;

                                end;

                                if i = 2 then begin
                                    "2ndapprover" := ApprovalEntries."Approver ID";
                                    "2ndapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                    if UserRecApp2.GET("2ndapprover") then begin
                                        UserRecApp2.CALCFIELDS(UserRecApp2.Picture);
                                        if Emp.GET(UserRecApp2."Employee No.") then
                                            Jobtitle2 := Emp."Job Title"; //MESSAGE('%1',"2ndapprover");
                                    end;
                                end;

                                if i = 3 then begin
                                    "3rdapprover" := ApprovalEntries."Approver ID";
                                    "3rdapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                    if UserRecApp3.GET("3rdapprover") then begin
                                        UserRecApp3.CALCFIELDS(UserRecApp3.Picture);
                                        if Emp.GET(UserRecApp3."Employee No.") then
                                            Jobtitle3 := Emp."Job Title";
                                    end;

                                    //MESSAGE('%1',"3rdapprover");
                                end;

                            until ApprovalEntries.NEXT = 0;
                        end;*/

                    /*
                    //=======Brian K================
                    IF "3rdapprover"='' THEN BEGIN
                          ApprovalEntries.RESET;
                          ApprovalEntries.SETCURRENTKEY("Sequence No.");
                          ApprovalEntries.SETRANGE(ApprovalEntries."Table ID",51511126);
                          ApprovalEntries.SETRANGE(ApprovalEntries."Document No.","Request Header"."No.");
                          ApprovalEntries.SETRANGE(ApprovalEntries.Status,ApprovalEntries.Status::Approved);
                          IF ApprovalEntries.FINDLAST THEN      BEGIN
                                "3rdapprover":=ApprovalEntries."Approver ID";
                                "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                                 IF UserRecApp3.GET("3rdapprover") THEN BEGIN
                                 UserRecApp3.CALCFIELDS(UserRecApp3.Picture);
                                 IF Emp.GET(UserRecApp3."Employee No.") THEN
                                 Jobtitle3:=Emp."Job Title";
                                 END;
                          END;
                    END;


                end

                else begin


                    ApprovalEntries.RESET;
                    ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 51511126);
                    ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", "Request Header"."No.");
                    ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                    if ApprovalEntries.FIND('-') then begin
                        i := 0;
                        repeat
                            i := i + 1;//MESSAGE('%1..%2',i,ApprovalEntries."Approver ID");
                            if i = 1 then begin
                                "1stapprover" := ApprovalEntries."Sender ID";
                                "1stapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp1.GET("1stapprover") then begin
                                    UserRecApp1.CALCFIELDS(UserRecApp1.Picture);
                                    if Emp.GET(UserRecApp1."Employee No.") then
                                        Jobtitle1 := Emp."Job Title";
                                end;


                                "2ndapprover" := ApprovalEntries."Approver ID";
                                "2ndapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp2.GET("2ndapprover") then begin
                                    UserRecApp2.CALCFIELDS(UserRecApp2.Picture);
                                    if Emp.GET(UserRecApp2."Employee No.") then
                                        Jobtitle2 := Emp."Job Title"; //MESSAGE('%1',"2ndapprover");
                                end;
                            end;

                            if i = 3 then begin
                                "3rdapprover" := ApprovalEntries."Approver ID";
                                "3rdapproverdate" := ApprovalEntries."Last Date-Time Modified";
                                if UserRecApp3.GET("3rdapprover") then begin
                                    UserRecApp3.CALCFIELDS(UserRecApp3.Picture);
                                    if Emp.GET(UserRecApp3."Employee No.") then
                                        Jobtitle3 := Emp."Job Title";
                                end;

                                //MESSAGE('%1',"3rdapprover");
                            end;

                        until ApprovalEntries.NEXT = 0;
                    end;


                end;*/
                    //=======Brian K================
                    /*
                    IF "3rdapprover"='' THEN BEGIN
                          ApprovalEntries.RESET;
                          ApprovalEntries.SETCURRENTKEY("Sequence No.");
                          ApprovalEntries.SETRANGE(ApprovalEntries."Table ID",51511126);
                          ApprovalEntries.SETRANGE(ApprovalEntries."Document No.","Request Header"."No.");
                          ApprovalEntries.SETRANGE(ApprovalEntries.Status,ApprovalEntries.Status::Approved);
                          IF ApprovalEntries.FINDLAST THEN      BEGIN
                                "3rdapprover":=ApprovalEntries."Approver ID";
                                "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                                 IF UserRecApp3.GET("3rdapprover") THEN BEGIN
                                 UserRecApp3.CALCFIELDS(UserRecApp3.Picture);
                                 IF Emp.GET(UserRecApp3."Employee No.") THEN
                                 Jobtitle3:=Emp."Job Title";
                                 END;
                          END;
                    END;*/
                    /*
                    //==============================
                    "Request Header".CALCFIELDS("Request Header".Balance, "Request Header"."Imprest Amount", "Request Header"."Actual Amount", "Request Header"."Total Amount Requested", "Request Header"."Claim accounting Balance");
                    Netamt := "Request Header"."Imprest Amount" - "Request Header"."Actual Amount";
                    //Amountdue:=
                    //MESSAGE('%1',"Request Header"."Imprest Amount");
                    //MESSAGE('%1',"Request Header"."Claim accounting Balance");


                    if reqheader.GET("No.")
                    then begin

                        Refnumber := reqheader."Imprest/Advance No";
                        //MESSAGE('%1',Refnumber);

                        /*IF reqheader2.GET(Refnumber)
                        THEN
                        Impamount:=reqheader2."Imprest Amount";
                        MESSAGE('%1',Impamount);

                    end;
                    requestlines.RESET;
                    requestlines.SETRANGE("Document No", "Request Header"."Imprest/Advance No");
                    requestlines.CALCSUMS("Requested Amount");
                    Impamount := requestlines."Requested Amount";
                    //MESSAGE('%1',Impamount);

                    Amountdue := "Request Header"."Imprest Amount" - Impamount;
                    //MESSAGE('%1',Amountdue);
                    //====================================IMRPEST TOTAL AMOUNT====================
                    Impamount2 := 0;
                    if reqheader2.GET("Request Header"."Imprest/Advance No")
                    then begin
                        if reqheader2."Imprest/Advance No" <> '' then
                            requestlines.RESET;
                        requestlines.SETRANGE("Document No", reqheader2."Imprest/Advance No");
                        requestlines.CALCSUMS("Requested Amount");
                        Impamount2 := requestlines."Requested Amount"
                        //MESSAGE('%1',requestlines."Requested Amount");
                    end;

                    InitTextVariable;
                    FormatNoText(NumberText, "Total Amount Requested", '');



                    //===============================================================================
                    //MESSAGE('%1..%2',"Request Header".Type,IMPREST_CLAIM_FORMCaptionLbl);
                    if ("Request Header".Type = "Request Header".Type::PettyCash) then begin
                        Headertxt := 'PETTY CASH VOUCHER';
                    end;
                    if ("Request Header".Type <> "Request Header".Type::PettyCash) then begin
                        Headertxt := 'IMPREST/FIELD ADVANCE APPLICATION FORM';
                    end;
                    if ("Request Header".Type = "Request Header".Type::"PettyCash Claim") then begin
                        Headertxt := 'PETTY CASH SURRENDER FORM';
                    end;*/
                    ApprovalEntries.RESET;
                    ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 51513031);
                    ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", "Payments HeaderFin"."No.");
                    ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                    // TotalApprovals := ApprovalEntries.COUNT;
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
        Name = 'Name of applicant'; Designation = 'Designation'; StaffNo = 'Personal Number'; Dept = 'Department'; ApplyText = 'Amount applied for (Kshs)..'; InWords = 'In Words'; PurposesText = 'Purpose of Imprest'; NatureOfDuty = 'Nature of duty.'; ItineraryLbl = 'Proposed Itinerary'; NoOfDaysLbl = 'Estimated Number of days away from station'; DateLbl = 'Date'; ApplSignatureLbl = 'Signature of Applicant'; AuthorizeText = '(i) I hereby authorize the journey and confirm that funds are available to meet the expenses and that the amount is realistic and proper charge against public funds'; CertifyText = '(ii) I Certify that the applicant is an employee of the Authority'; DFACmmnts = 'DFA Comments'; DGDFALbl = 'Director General/Director Finance & Administration'; ImprestAccountantIC = 'Accountant -in-charge Imprest'; VBCAccountantText = 'I certify that the amount has been noted in the imprest register/Votebook.'; VBCAccountantICLbl = 'Accountant -in-charge- Votebook Control'; AuthorizationLbl = 'Authorization:'; ChiefAccountantLbl = 'Chief Accountant'; PostingLbl = 'Posting:'; PostedByLbl = 'Posted by'; Sign = 'Signature'; Date = 'Date:'; Sign1 = 'Signature of applicant';
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
        DimValues: Record "Dimension Value";
        CompName: Text[100];
        TypeOfDoc: Text[100];

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
        TXT002: Label '%1, %2  %3';
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
        Netamt: Decimal;
        IMPREST_CLAIM_FORMCaptionLbl: Label 'IMPREST/FIELD ADVANCE APPLICATION FORM';
        Department_CaptionLbl: Label 'Department :';
        DescriptionCaptionLbl: Label 'Description :';
        AmountCaptionLbl: Label 'Amount';
        TOTAL_EXPENSESCaptionLbl: Label 'TOTAL ADVANCE';
        LESS__ADVANCECaptionLbl: Label 'LESS: TOTAL EXPENSES';
        AMOUNT_DUE_TO__FROM__EMPLOYEECaptionLbl: Label 'AMOUNT DUE TO/(FROM) EMPLOYEE';
        PAYMENT_RECEIVED_BYCaptionLbl: Label 'PAYMENT RECEIVED BY';
        SIGNATURE__________________________________________________CaptionLbl: Label 'SIGNATURE';
        DATE__________________________________________________CaptionLbl: Label '"DATE "';
        APPROVED_BY_CaptionLbl: Label '2. APPROVED BY:';
        SIGNATURE_CaptionLbl: Label 'SIGNATURE:';
        DATE__________________________________________________Caption_Control1000000036Lbl: Label 'DATE:';
        CHECKED_BY_CaptionLbl: Label '"3. AUTHORIZED BY: "';
        SIGNATURECaptionLbl: Label 'SIGNATURE:';
        DATE__________________________________________________Caption_Control1000000042Lbl: Label 'DATE:';
        PREPARED_BYCaptionLbl: Label '1. PREPARED:';
        SIGNATURECaption_Control1000000055Lbl: Label 'SIGNATURE:';
        DATE__________________________________________________Caption_Control1000000062Lbl: Label 'DATE:';
        APPROVALCaptionLbl: Label 'APPROVAL';
        FooterLbl: Label '"""Our Environment | Our Life | Our Responsibility"""';
        RemarksLbl: Label 'Remarks:';
        AccountDesFootLbl: Label 'Account Description';
        AccountNameLbl: Label 'Account Name';
        ChequeDateLbl: Label 'Cheque/EFT Date:';
        ChequeNoLbl: Label 'Cheque No/EFT No:';
        BankLbl: Label 'Bank:';
        ImprestDetailsLbl: Label 'IMPREST DETAILS';
        DesignationLbl: Label 'Designaition:';
        VoteLbl: Label 'Vote';
        AccNoLbl: Label 'Account No';
        AmtLbl: Label 'Total Amount';
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
        DepartmentName: Text;
        Emp: Record Employee;
        JobTitle: Text;
        Text100: Label '" %1 | %2 | Mobile Phone: %3 | Email: %4 | Website: %5 | PIN No: %6"';
        IAFNoLbl: Label 'IAF No:';
        Jobtitle1: Text;
        Jobtitle2: Text;
        Jobtitle3: Text;
        CustName: Text;
        Headertxt: Text;
        dimvalue: Record "Dimension Value";
        LESSADVANCEAMOUNT: Decimal;
        TOTALDUE: Decimal;
        requestlines: Record "Petty Cash Lines";
        reqheader: Record "Payments HeaderFin";
        Amountdue: Decimal;
        Refnumber: Code[30];
        Impamount: Decimal;
        reqheader2: Record "Payments HeaderFin";
        Impamount2: Decimal;

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

