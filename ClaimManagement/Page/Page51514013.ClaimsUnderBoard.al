page 51514013 "Claims Under Board"
{

    PageType = List;
    SourceTable = "Guarantee Claim Line";
    Caption = 'Claims Under Board';
    CardPageId = "Board Claim Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    Editable = false;
    SourceTableView = sorting("Claim No.", "Line No.") where("Approval Status" = const(Approved), Completed = const(true), "Claim Steps" = const("Board Approval"));

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
                field("Board Status"; "Board Status")
                {

                }

            }
        }

    }


}
