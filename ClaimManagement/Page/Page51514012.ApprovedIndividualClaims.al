page 51514012 "Approved Individual Claims"
{

    PageType = List;
    SourceTable = "Guarantee Claim Line";
    Caption = 'Approved Individual Claims';
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    Editable = false;
    SourceTableView = sorting("Claim No.", "Line No.") where("Approval Status" = const(Approved), Completed = const(true), "Claim Steps" = const("Mgmt Approval"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Claim No."; "Claim No.")
                {
                    ApplicationArea = All;
                }
                field("Contract No."; "Contract No.")
                {
                    ApplicationArea = All;
                }
                field("Client No."; "Client No.")
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
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("CGC No."; "CGC No.")
                {
                    ApplicationArea = All;
                }
                field("CGC Amount"; "CGC Amount")
                {
                    ApplicationArea = All;
                }
                field("Payable Amount"; "Payable Amount")
                {
                    ApplicationArea = All;
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Move to Board")
            {
                Caption = 'Send to Board';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;
                trigger OnAction()
                var
                    CUClaimMgmt: Codeunit "Claim Management";
                begin
                    CUClaimMgmt.FnMoveClaimsToBoards("Claim No.", "Line No.");
                end;
            }
        }
    }

}
