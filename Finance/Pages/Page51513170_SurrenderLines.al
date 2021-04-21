page 51513170 "Surrender Lines"
{
    PageType = ListPart;
    SourceTable = "Imprest Lines";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; No)
                {
                    Visible = false;
                }
                field("Line No"; "Line No")
                {
                    Visible = false;
                }
                field("Transaction Type"; "Transaction Type")
                {

                }
                field("Expense Type"; "Expense Type")
                {

                }
                field("Account Type"; "Account Type")
                {
                    Editable = false;
                }
                field("Account No."; "Account No.")
                {
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    Editable = false;
                }
                field(Description; Description)
                {

                }
                field(Amount; Amount)
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Actual Spent"; "Actual Spent")
                {

                }
                field("Remaining Amount"; "Remaining Amount")
                {

                }
                field("Reason for Overspending"; "Reason for Overspending")
                {

                }
            }

        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)

    begin

        //IF ImprestHeader.GET(No) THEN
        //   ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean

    begin

        //IF ImprestHeader.GET(No) THEN
        //  ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean

    begin

        //IF ImprestHeader.GET(No) THEN
        // ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    trigger OnDeleteRecord(): Boolean

    begin

        IF ImprestHeader.GET(No) THEN
            ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    var

    var
        ImprestHeader: Record "Payments HeaderFin";
}