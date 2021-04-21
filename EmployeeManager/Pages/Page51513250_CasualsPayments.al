page 51513250 "Casuals Payments"
{
    PageType = Card;
    SourceTable = "Casuals Payments";
    Caption = 'Casuals Payments';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                }
                field("Payroll Period"; "Payroll Period")
                {
                }
                field(Unit; Unit)
                {
                }
                field("Date Prepared"; "Date Prepared")
                {
                }
                field("Unit Name"; "Unit Name")
                {
                }
                field("User ID"; "User ID")
                {
                }
                field(Status; Status)
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field("Batch No"; "Batch No")
                {
                }
            }
            part(Control11; "Casual Payment Lines")
            {
                SubPageLink = Code = FIELD (Code);
            }
        }
    }

    actions
    {
        area(creation)
        {

            action("Insert Casuals")
            {
                Caption = 'Insert Casuals';

                trigger OnAction();
                begin
                    PayrollPre.InsertCasuals(Rec);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "User ID" := USERID;
    end;

    var
        PayrollPre: Codeunit "Overtime Payroll Computation";
}

