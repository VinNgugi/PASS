page 51514014 "Board Claim Card"
{

    PageType = Card;
    SourceTable = "Guarantee Claim Line";
    Caption = 'Board Claim Card';
    //Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("Claim No."; "Claim No.")
                {
                    ApplicationArea = All;
                }
                field("Contract No."; "Contract No.")
                {
                    ApplicationArea = All;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = All;
                }
                field("CGC No."; "CGC No.")
                {
                    ApplicationArea = All;
                }
                field(Product; Product)
                {
                    ApplicationArea = All;
                }
                field("CGC Amount"; "CGC Amount")
                {
                    ApplicationArea = All;
                }
                field("CGC Date"; "CGC Date")
                {
                    ApplicationArea = All;
                }
                field("CGC Start Date"; "CGC Start Date")
                {
                    ApplicationArea = All;
                }
                field("CGC Expiry Date"; "CGC Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("CGF %"; "CGF %")
                {
                    ApplicationArea = All;
                }
                field("Last Aging Date"; "Last Aging Date")
                {
                    ApplicationArea = All;
                }
                field("Claim Amount"; "Claim Amount")
                {
                    ApplicationArea = All;
                }
                field("Days in Arrears"; "Days in Arrears")
                {
                    ApplicationArea = All;
                }
                field("Approved Loan Amount"; "Approved Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Loan Maturity Date"; "Loan Maturity Date")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Principal Amt"; "Outstanding Principal Amt")
                {
                    ApplicationArea = All;
                }
                field("SalesPerson Code"; "SalesPerson Code")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Guarantee Source"; "Guarantee Source")
                {
                    ApplicationArea = All;
                }

            }
            part("Bank Recovery Lines"; "Bank Recovery Lines")
            {
                Editable = false;
                Caption = 'Bank Recovery Options';
                SubPageLink = "Claim No." = field("Claim No."), "Contract No." = field("Contract No.");
            }

            group("BDO/BDM Fill Details")
            {
                Editable = false;

                field(BankRecEffortExhausted; BankRecEffortExhausted)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Reason For Default"; "Reason For Default")
                {
                    MultiLine = true;
                }
                field("Additional Infor on Default"; "Additional Infor on Default")
                {
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Payable Amount"; "Payable Amount")
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Paid; Paid)
                {
                    ApplicationArea = All;
                }
            }
            group("Board Meeting Details")
            {
                field("Board Meeting Number"; "Board Meeting Number")
                {

                }
                field("Board Meeting Date"; "Board Meeting Date")
                {

                }
                field(PayableAmount; "Payable Amount")
                {
                    Caption = 'Approved Amount';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Approve Claim")
            {
                Caption = 'Approve Claim';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = "Board Status" = "Board Status"::Open;

                trigger OnAction()
                var
                    myInt: Integer;
                begin

                    TestField("Board Meeting Number");
                    TestField("Board Meeting Date");
                    TestField("Payable Amount");



                    //***************Create Claim Invoice*****************//
                    CUClaimMgmt.FnCreateClaimInvoice(Rec);
                    //***************Create Claim Invoice*****************//

                    //***Finally Change status to Approved***//
                    "Board Status" := "Board Status"::Approved;
                    Modify();
                end;
            }
            action("Reject Claim")
            {
                Caption = 'Reject Claim';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = "Board Status" = "Board Status"::Open;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    "Board Status" := "Board Status"::Rejected;
                    Modify();
                end;
            }
            /*action("Send Back to Bank")
            {
                Caption = 'Send Back to Bank';
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = "Approval Status" = "Approval Status"::Open;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    "Approval Status" := "Approval Status"::"Return To Bank";
                    Modify();
                end;
            }*/
            action("View Clients Loans")
            {
                Caption = 'View Clients Loans';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Guarantee Contracts";
                RunPageLink = "Customer No." = field("Client No.");
            }
            group(AttachmentstoEDMS)
            {
                action("Attach Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Add a file as an attachment to EDMS. You can attach images as well as documents.';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                    begin
                        //OnAttachDocuments(Rec);
                    end;
                }
                action("View Attached Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'View attached files in EDMS.';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var

                    begin
                        //OnViewAttachedDocuments(Rec);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var

    begin

    end;



    var
        CUClaimMgmt: Codeunit "Claim Management";

}
