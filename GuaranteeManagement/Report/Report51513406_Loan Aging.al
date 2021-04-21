
report 51513406 "Loan Aging"
{
    Caption = 'Loan Aging';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Loan Aging.rdl';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting ("Primary Key");

            column(Name_; Name)
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
            Column(Page_No_; CurrReport.PAGENO)
            {

            }

            dataitem("Guarantee Contracts"; "Guarantee Contracts")
            {
                column(Product; Product)
                {

                }
                column(BankName; BankName)
                {

                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {

                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                {

                }
                column(Global_Dimension_3_Code; "Global Dimension 3 Code")
                {

                }
                column(Global_Dimension_4_Code; "Global Dimension 4 Code")
                {

                }
                column(GlobalDimIText; GlobalDimIText)
                {

                }
                column(GlobalDim2Text; GlobalDim2Text)
                {

                }
                column(Subsector; Subsector)
                {

                }
                column(LineOfBusiness; LineOfBusiness)
                {

                }
                column(Old_Loan_No; "Old Loan No")
                {

                }
                dataitem(MainItem; "Loan Account Entries")
                {
                    DataItemLink = "Contract No." = field ("No.");

                    column(Counter_; Counter)
                    {

                    }
                    column("Contract_No_"; "Contract No.")
                    {

                    }
                    column("Loan_No"; "Loan No")
                    {

                    }

                    column("Customer_Name"; "Customer Name")
                    {
                        Caption = 'Client Name';
                    }


                    column("Approved_Amount"; "Approved Amount")
                    {
                        Caption = 'Loan Amount';
                    }

                    column("Disbursed_Amount"; "Disbursed Amount")
                    {

                    }

                    column("Outstanding_Principal_Amt"; "Outstanding Principal Amt")
                    {

                    }

                    column("Repayment_Installment_Amt"; "Repayment Installment Amt")
                    {

                    }

                    column("Total_Exposure"; "Total Exposure")
                    {

                    }

                    column("Principal_Amt"; "Total Principal Amt Paid")
                    {

                    }

                    column("Interest_Amt_Accrued"; "Interest Amt Accrued")
                    {

                    }

                    column("Principal_Amt_In_Arrears"; "Principal Amt In Arrears")
                    {

                    }

                    column("Interest_Amt_In_Arrears"; "Interest Amt In Arrears")
                    {

                    }

                    column("Total_No__of_Installments"; "Total No. of Installments")
                    {

                    }

                    column("No__of_Installments_In_Arrears"; "No. of Installments In Arrears")
                    {

                    }

                    column("Guarantee"; "Guarantee")
                    {

                    }

                    column("Guarantee_Amt"; "Guarantee Amt")
                    {

                    }

                    column("System_Classification"; "System Classification")
                    {

                    }

                    column("Loan_Disbursed_Date"; "Loan Disbursed Date")
                    {

                    }

                    column("Loan_Maturity_Date"; "Loan Maturity Date")
                    {

                    }

                    column("Days_Past_Due"; "Days Past Due")
                    {

                    }

                    column("Reporting_Date"; "Reporting Date")
                    {

                    }


                    column("Bank_Brach_Name"; "Bank Brach Name")
                    {

                    }

                    column("Bank"; "Bank")
                    {

                    }

                    column("Loan_Value_Date"; "Loan Value Date")
                    {

                    }

                    column("Date_Imported"; "Date Imported")
                    {

                    }

                    column("Time_Imported"; "Time Imported")
                    {

                    }

                    column("Imported_By"; "Imported By")
                    {

                    }
                    column(Counter; Counter)
                    {

                    }


                    trigger Onpredataitem()

                    begin
                        SetRange("Reporting Date", ReportingDate);
                    end;

                    trigger OnAfterGetRecord()

                    begin
                        SetRange("Reporting Date", ReportingDate);
                        Counter := Counter + 1;

                        //if CustRec.Get("Guarantee Contracts"."Receivables Acc. No.") then begin

                        //end;

                    end;

                    trigger OnPostDataItem()
                    var
                        myInt: Integer;
                    begin
                        SetRange("Reporting Date", ReportingDate);
                    end;

                }


                trigger OnAfterGetRecord()

                begin
                    IF BankCode <> '' then
                        SetRange("Receivables Acc. No.", BankCode);

                    AgingRec.Reset;
                    AgingRec.SetRange("Contract No.", "No.");
                    AgingRec.SetRange("Reporting Date", ReportingDate);
                    if AgingRec.FindFirst then begin
                        if CustRec.Get("Receivables Acc. No.") then
                            BankName := CustRec.Name;


                    end else
                        CurrReport.Skip();

                    DimVal.Reset();
                    DimVal.SetRange("Global Dimension No.", 1);
                    DimVal.SetRange(Code, "Global Dimension 1 Code");
                    if DimVal.Find('-') then begin
                        GlobalDimIText := DimVal.Name;
                    end else
                        GlobalDimIText := '';

                    DimVal.Reset();
                    DimVal.SetRange("Global Dimension No.", 2);
                    DimVal.SetRange(Code, "Global Dimension 2 Code");
                    if DimVal.Find('-') then begin
                        GlobalDim2Text := DimVal.Name;
                    end else
                        GlobalDim2Text := '';

                    SubSectorLOB.Reset();
                    SubSectorLOB.SetRange("Client No.", "No.");
                    if SubSectorLOB.Find('-') then begin
                        Subsector := SubSectorLOB.Subsector;
                        LineOfBusiness := SubSectorLOB."Line of Business";
                    end else begin
                        Subsector := '';
                        LineOfBusiness := '';
                    end;
                end;
            }


        }


    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("Reporting Period End Date"; ReportingDate)
                    {


                    }
                    field(Bank; BankCode)
                    {
                        TableRelation = Customer."No." where ("Customer Posting Group" = filter ('BANKS'));
                    }
                }
            }
        }
    }


    trigger OnPreReport()

    begin
        if ReportingDate = 0D THEN
            Error('Kindly specify reporting period end date');
    end;

    var
        Counter: Integer;
        BankName: Text;
        CustRec: Record Customer;
        AgingRec: Record "Loan Account Entries";
        ReportingDate: Date;
        DimVal: Record "Dimension Value";
        GlobalDimIText: Text;
        GlobalDim2Text: Text;
        Subsector: Text;
        LineOfBusiness: Text;
        SubSectorLOB: Record "Subsector & Line of Business";
        BankCode: Code[20];
}