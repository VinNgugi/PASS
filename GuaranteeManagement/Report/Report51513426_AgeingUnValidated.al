report 51513426 "Ageing UnValidated Entries"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Ageing UnValidated Entries';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Ageing UnValidated Entries.rdl';

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
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            dataitem("Validation Table"; "Validation Table")
            {
                RequestFilterFields = "No.", Banks;
                column(No_; "No.")
                {

                }
                column(Banks; Banks)
                {

                }
                column(Bank_Name; "Bank Name")
                {

                }
                column(Quarter; Quarter)
                {

                }
                column(Validated_Entries; "Validated Entries")
                {

                }
                column(Total_Entries; "Total Entries")
                {

                }
                dataitem("Validation Lines"; "Validation Lines")
                {
                    DataItemTableView = sorting () order(ascending) where (validated = const (true));
                    DataItemLink = "Header No" = field ("No.");

                    column(Contract_No_; "Contract No.")
                    {

                    }
                    column(Loan_No; "Loan No")
                    {

                    }
                    column(Customer_Name; "Customer Name")
                    {

                    }
                    column(Account_No_; "Account No.")
                    {

                    }
                    column(Product_Type; "Product Type")
                    {

                    }
                    column(BankName; BankName)
                    {

                    }
                    column(BankBranchName; BankBranchName)
                    {

                    }
                    column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {

                    }
                    column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {

                    }
                    column(Approved_Amount; "Approved Amount")
                    {

                    }
                    column(Disbursed_Amount; "Disbursed Amount")
                    {

                    }
                    column(Repayment_Installment_Amt; "Repayment Installment Amt")
                    {

                    }
                    column(Total_Exposure; "Total Exposure")
                    {

                    }
                    column(Total_Principal_Amt_Paid_; "Total Principal Amt Paid ")
                    {

                    }
                    column(Outstanding_Principal_Amt; "Outstanding Principal Amt")
                    {

                    }
                    column(Interest_Amt_Accrued; "Interest Amt Accrued")
                    {

                    }
                    column(Principal_Amt_In_Arrears; "Principal Amt In Arrears")
                    {

                    }
                    column(Interest_Amt_In_Arrears; "Interest Amt In Arrears")
                    {

                    }
                    column(Guarantee; Guarantee)
                    {

                    }
                    column(Guarantee_Amt; "Guarantee Amt")
                    {

                    }
                    column(System_Classification; "System Classification")
                    {

                    }
                    column(Loan_Value_Date; "Loan Value Date")
                    {

                    }
                    column(Loan_Maturity_Date; "Loan Maturity Date")
                    {

                    }
                    column(Validated; Validated)
                    {

                    }
                    column(Repeated_Entry; "Repeated Entry")
                    {

                    }
                }

                trigger OnPredataItem()
                var

                begin

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

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
        myInt: Integer;
        BankName: Text;
        BankBranchName: Text;

}