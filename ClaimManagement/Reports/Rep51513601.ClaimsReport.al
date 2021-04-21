report 51513601 "Claims Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Claims Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Claims Report.rdl';
    dataset
    {
        dataitem(GuaranteeClaimLine; "Guarantee Claim Line")
        {
            RequestFilterFields = "Approval Status", "Board Status", "Claim No.", "Client No.";
            column(ClaimNo; "Claim No.")
            {
            }
            column(ClientNo; "Client No.")
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(ContractNo; "Contract No.")
            {
            }
            column(LoanNo; "Loan No.")
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
            column(ApprovalStatus; "Approval Status")
            {
            }
            column(ClaimAmount; "Claim Amount")
            {
            }
            column(BoardStatus; "Board Status")
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
