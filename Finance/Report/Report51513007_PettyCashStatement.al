report 51513007 "Petty Cash Statement"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Petty Cash Statement';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Petty Cash Statement.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name)
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

            dataitem("Bank Account"; "Bank Account")
            {
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter", "Global Dimension 1 Filter";
                DataItemTableView = sorting ("No.") where ("Bank Acc Type" = const ("Petty Cash"));

                column(No_; "No.")
                {

                }
                column(BankName; Name)
                {

                }
                column(Currency_Code; "Currency Code")
                {

                }
                column(Date_Filter; "Date Filter")
                {

                }
                column(Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                {

                }
                column(Balance_at_Date; "Balance at Date")
                {

                }
                column(StartBalance; StartBalance)
                {

                }
                column(RunningBal; RunningBal)
                {

                }
                column(BankAccFilter; BankAccFilter)
                {

                }
                column(BankAccDateFilter; BankAccDateFilter)
                {

                }
                column(Cashier_ID; "Cashier ID")
                {

                }

                dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
                {
                    DataItemTableView = sorting ("Bank Account No.", "Posting Date");
                    DataItemLink = "Bank Account No." = field ("No."), "Posting Date" = field ("Date Filter"), "Global Dimension 1 Code" = field ("Global Dimension 1 Filter");

                    column(Posting_Date; "Posting Date")
                    {

                    }
                    column(Document_No_; "Document No.")
                    {

                    }
                    column(Description; Description)
                    {

                    }
                    column(Amount; Amount)
                    {

                    }
                    column(Debit_Amount; "Debit Amount")
                    {

                    }
                    column(Credit_Amount; "Credit Amount")
                    {

                    }
                    column(Bank_Account_No_; "Bank Account No.")
                    {

                    }
                    column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {

                    }
                    column(SN; SN)
                    {

                    }
                    column(Names; Names)
                    {

                    }
                    column(Bal__Account_No_; "Bal. Account No.")
                    {

                    }

                    trigger OnPredataItem()
                    var

                    begin
                        BankAccLedgEntryExists := FALSE;
                        CurrReport.CREATETOTALS(Amount, "Amount (LCY)");
                    end;

                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                    begin
                        IF NOT PrintReversedEntries AND Reversed THEN
                            CurrReport.SKIP;
                        BankAccLedgEntryExists := TRUE;
                        BankAccBalance := BankAccBalance + Amount;
                        BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)";

                        Names := '';
                        IF "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."Bal. Account Type"::Customer THEN BEGIN
                            IF Cust.GET("Bank Account Ledger Entry"."Bal. Account No.") THEN
                                Names := Cust.Name;
                        END ELSE
                            IF "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."Bal. Account Type"::Vendor THEN BEGIN
                                IF Vend.GET("Bank Account Ledger Entry"."Bal. Account No.") THEN
                                    Names := Vend.Name;
                                //PayrollNo := Vend."Personal No.";
                            END
                            ELSE
                                IF "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."Bal. Account Type"::"Bank Account" THEN BEGIN
                                    IF Bank.GET("Bank Account Ledger Entry"."Bal. Account No.") THEN
                                        Names := Bank.Name;
                                END
                                else
                                    if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."Bal. Account Type"::"G/L Account" then begin
                                        if GLAcc.Get("Bal. Account No.") then
                                            Names := GLAcc.Name;
                                    end;

                        TCredit := TCredit + "Bank Account Ledger Entry"."Credit Amount";
                        TDebit := TDebit + "Bank Account Ledger Entry"."Debit Amount";
                        RunningBal := RunningBal + Amount;

                        SN := SN + 1;
                    end;
                }
                trigger OnPredataItem()
                var

                begin
                    CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                    CurrReport.CREATETOTALS("Bank Account Ledger Entry"."Amount (LCY)", StartBalanceLCY);
                    BankAccFilter := "Bank Account".GETFILTERS;
                    BankAccDateFilter := "Bank Account".GETFILTER("Date Filter");
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    StartBalance := 0;
                    TCredit := 0;
                    TDebit := 0;

                    IF BankAccDateFilter <> '' THEN
                        IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                            SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                            CALCFIELDS("Net Change", "Net Change (LCY)");
                            StartBalance := "Net Change";
                            StartBalanceLCY := "Net Change (LCY)";
                            SETFILTER("Date Filter", BankAccDateFilter);
                        END;
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalance = 0);
                    BankAccBalance := StartBalance;
                    RunningBal := StartBalance;
                    BankAccBalanceLCY := StartBalanceLCY;
                end;
            }
            trigger OnPredataItem()
            var

            begin
                "Company Information".CalcFields(Picture)
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        PrintOnlyOnePerPage: Boolean;
        BankAccFilter: Text;
        BankAccDateFilter: Text;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        TCredit: Decimal;
        TDebit: Decimal;
        ExcludeBalanceOnly: Boolean;
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        Names: Text;
        Cust: Record Customer;
        Vend: Record Vendor;
        Bank: Record "Bank Account";
        SN: Integer;
        GLAcc: Record "G/L Account";
        RunningBal: Decimal;


}