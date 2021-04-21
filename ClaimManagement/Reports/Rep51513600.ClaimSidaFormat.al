report 51513600 ClaimSidaFormat
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Claim SIDA Format Internal MEMO';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Claim SIDA Format Internal MEMO.rdl';
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
            dataitem(Claim; Claim)
            {
                column(No; "No.")
                {
                }
                column(ApprovalStatus; "Approval Status")
                {
                }
                column(ClaimDate; "Claim Date")
                {
                }
                column(ClaimDesscrition; "Claim Desscrition")
                {
                }
                column(ClaimType; "Claim Type")
                {
                }
                column(ClaimingBankAmount; "Claiming Bank Amount")
                {
                }
                column(ClaimingBankAmountLCY; "Claiming Bank Amount(LCY)")
                {
                }
                column(CreatedBy; "Created By")
                {
                }
                column(CurrencyCode; "Currency Code")
                {
                }
                column(CurrencyFactor; "Currency Factor")
                {
                }
                column(CustomerName; "Customer Name")
                {
                }
                column(CustomerNo; "Customer No.")
                {
                }
                column(CustomerPhone; "Customer Phone")
                {
                }
                column(DateCreated; "Date Created")
                {
                }
                column(DocumentDate; "Document Date")
                {
                }
                column(ModifiedBy; "Modified By")
                {
                }
                column(ReferenceNo; "Reference No.")
                {
                }
                column(TotalAmount; "Total Amount")
                {
                }
                column(TotalApprovedClaimAmount; "Total Approved Claim Amount")
                {
                }
                column(TotalNoofClients; "Total No. of Clients")
                {
                }
                column(Description; Description)
                {
                }
                column(Status; Status)
                {
                }
                dataitem("Guarantee Claim Line"; "Guarantee Claim Line")
                {
                    DataItemLink = "Claim No." = field("No.");
                    column(ApprovalStatusLines; "Approval Status")
                    {
                    }
                    column(ApprovedAmount; "Approved Amount")
                    {
                    }
                    column(ApprovedLoanAmount; "Approved Loan Amount")
                    {
                    }
                    column(CGCAmount; "CGC Amount")
                    {
                    }
                    column(CGCDate; "CGC Date")
                    {
                    }
                    column(CGCExpiryDate; "CGC Expiry Date")
                    {
                    }
                    column(CGCNo; "CGC No.")
                    {
                    }
                    column(CGCStartDate; "CGC Start Date")
                    {
                    }
                    column(CGF; "CGF %")
                    {
                    }
                    column(ClaimAmount; "Claim Amount")
                    {
                    }
                    column(ClaimNo; "Claim No.")
                    {
                    }
                    column(ClientName; "Client Name")
                    {
                    }
                    column(ContractNo; "Contract No.")
                    {
                    }
                    column(DaysinArrears; "Days in Arrears")
                    {
                    }
                    column(GlobalDimension1Code; "Global Dimension 1 Code")
                    {
                    }
                    column(GlobalDimension2Code; "Global Dimension 2 Code")
                    {
                    }
                    column(GlobalDimension3Code; "Global Dimension 3 Code")
                    {
                    }
                    column(GlobalDimension4Code; "Global Dimension 4 Code")
                    {
                    }
                    column(GuaranteeSource; "Guarantee Source")
                    {
                    }
                    column(LastAgingDate; "Last Aging Date")
                    {
                    }
                    column(LineNo; "Line No.")
                    {
                    }
                    column(LoanMaturityDate; "Loan Maturity Date")
                    {
                    }
                    column(LoanNo; "Loan No.")
                    {
                    }
                    column(OutstandingPrincipalAmt; "Outstanding Principal Amt")
                    {
                    }
                    column(PayableAmount; "Payable Amount")
                    {
                    }
                    column(SalesPersonCode; "SalesPerson Code")
                    {
                    }
                    column(Paid; Paid)
                    {
                    }
                    column(Product; Product)
                    {
                    }
                }
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

            trigger OnPostDataItem()
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
            area(content)
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
            }
        }
    }
}
