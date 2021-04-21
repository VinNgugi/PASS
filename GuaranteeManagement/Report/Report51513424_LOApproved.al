report 51513424 "Lenders Option Loans Approved"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'LO Approved';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/LO Approved.rdl';


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
            dataitem("Guarantee Contracts"; "Guarantee Contracts")
            {
                RequestFilterFields = "Global Dimension 1 Code", Product, Bank, "BDS/BDO", "Contract Status", "Loan Issued Date";

                column(No_; "No.")
                {

                }
                column(ClientName; Name)
                {

                }
                column(Age; Age)
                {

                }
                column(RepeatingClient; "Repeating Client")
                {

                }
                column(Product; Product)
                {

                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {

                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                {

                }
                column(BDS_BDO; "BDS/BDO")
                {

                }
                column(Loan_Issued_Date; "Loan Issued Date")
                {

                }
                column(Currency_Code; "Currency Code")
                {

                }
                column(Approved_Loan_Amount; "Approved Loan Amount")
                {

                }
                column(Approved_Loan_Amount_LCY_; "Approved Loan Amount(LCY)")
                {

                }
                column(Bank; Bank)
                {

                }
                column(Receivables_Acc__No_; "Receivables Acc. No.")
                {

                }
                column(BankName; BankName)
                {

                }
                column(Bank_Branch; "Bank Branch")
                {

                }
                column(Contract_Status; "Contract Status")
                {

                }
                column(CGC_Committed_Funds; "CGC Committed Funds")
                {

                }
                column(PASS_Guarantee_Amount; "PASS Guarantee Amount")
                {

                }
                column(IFC_Guarantee_Amount; "IFC Guarantee Amount")
                {

                }
                column(SIDA_Guarantee_Amount; "SIDA Guarantee Amount")
                {

                }
                column(ClientPhone_No_; "Phone No.")
                {

                }
                column(Period; Period)
                {

                }
                column(PeriodText; PeriodText)
                {

                }
                column(FilterDim1; FilterDim1)
                {

                }
                column(FilterDim1Text; FilterDim1Text)
                {

                }
                column(Subject; Subject)
                {

                }
                column(DimensionName; DimensionName)
                {

                }
                column(CGC_Start_Date; "CGC Start Date")
                {

                }
                column(Loan_Maturity_Date; "Loan Maturity Date")
                {

                }
                column(CGF__; "CGF %")
                {

                }
                column(Gender; Gender)
                {

                }
                column(Loan_No_; "Loan No.")
                {

                }

                column(No__of_Female_Employees_Per_; "No. of Female Employees(Per)")
                {

                }
                column(No__of_Male_Employees_Per_; "No. of Male Employees(Per)")
                {

                }
                column(No__of_Male_Employees_Cas_; "No. of Male Employees(Cas)")
                {

                }
                column(No__of_Female_Employees_Cas_; "No. of Female Employees(Cas)")
                {

                }
                column(No_of_Employments_Created; "No of Employments Created")
                {

                }
                column(No__of_Male_Beneficiaries; "No. of Male Beneficiaries")
                {

                }
                column(No__of_Female_Beneficiaries; "No. of Female Beneficiaries")
                {

                }
                column(Total_No__of_Beneficiaries; "Total No. of Beneficiaries")
                {

                }
                column(Reference_No_; "Reference No.")
                {

                }
                column(Loan_Amount; "Loan Amount")
                {

                }
                column(Loan_Amount_LCY_; "Loan Amount(LCY)")
                {

                }

                dataitem("Subsector & Line of Business"; "Subsector & Line of Business")
                {
                    DataItemLink = "Client No." = field("No.");

                    column(Subsector; Subsector)
                    {

                    }
                    column(Line_of_Business; "Line of Business")
                    {

                    }
                    column(Type; Type)
                    {

                    }

                    dataitem("Guarantee Application"; "Guarantee Application")
                    {
                        DataItemLink = "No." = field("Client No.");

                        column(CheckedforE_SSustainability_; "CheckedforE&SSustainability?")
                        {

                        }
                        column(MeetMinimumRequirements_; "MeetMinimumRequirements?")
                        {

                        }
                        column(MitigationMeasuresAgreed_; "MitigationMeasuresAgreed?")
                        {

                        }
                        column(InvestmentInGreenSolutions_; "InvestmentInGreenSolutions?")
                        {

                        }
                        column(InvestmentInGreenSum; InvestmentInGreenSum)
                        {

                        }
                    }
                }


                trigger OnPredataItem()
                var

                begin
                    Period := "Guarantee Contracts".GETFILTER("Loan Issued Date");

                    IF (Period <> '') THEN
                        PeriodText := 'Approved Period ' + Period;


                    GetContractFilters("Guarantee Contracts");

                    /*ProductText := "Guarantee Contracts".GetFilter(Product);

                    if (ProductText <> '') then begin

                        ObjProduct.Reset();
                        ObjProduct.SetRange(Code, Product);
                        if ObjProduct.Find('-') then begin
                            if ObjProduct.Type = ObjProduct.Type::"Lenders Option" then
                                Subject := 'LENDERS OPTION LOANS APPROVED'
                            else
                                if ObjProduct.Type = ObjProduct.Type::Traditional then
                                    Subject := 'TRADITIONAL LOANS APPROVED';
                        end;
                    end else begin
                        Subject := 'LENDERS OPTION/TRADITIONAL LOANS APPROVED'
                    end;*/

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    if "Approved Loan Amount(LCY)" = 0 then begin
                        Validate("Approved Loan Amount");
                        Modify();
                    end;
                    Currency := '';

                    if "Currency Code" <> '' then
                        Currency := "Currency Code"
                    else
                        Currency := 'TZS';

                    BankName := '';
                    if Customer.Get("Receivables Acc. No.") then begin
                        BankName := Customer.Name;
                    end;

                    DimensionValue.Reset();
                    DimensionValue.SetRange("Global Dimension No.", 1);
                    DimensionValue.SetRange(Code, "Global Dimension 1 Code");
                    if DimensionValue.Find('-') then
                        DimensionName := DimensionValue.Name
                    else
                        DimensionName := '';

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

    local procedure GetContractFilters(var Contracts: Record "Guarantee Contracts")
    var
        myInt: Integer;
    begin
        GLSetup.GET;

        FilterDim1 := Contracts.GETFILTER("Global Dimension 1 Code");

        IF (FilterDim1 <> '') THEN BEGIN
            IF DimensionValue.GET(GLSetup."Global Dimension 1 Code", FilterDim1) THEN
                FilterDim1Text := DimensionValue.Name
            else
                FilterDim1Text := FilterDim1;
        END;
    end;

    var
        Currency: Code[10];
        Period: Text;
        PeriodText: Text;
        FilterDim1: Text;
        FilterDim1Text: Text[100];
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        ProductText: Text;
        ObjProduct: Record Products;
        Subject: Text;
        Customer: Record Customer;
        BankName: Text;
        BranchName: Text;
        DimensionName: Text;

}