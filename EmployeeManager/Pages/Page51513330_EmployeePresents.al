page 51513330 "Employee Presents"
{
    // version HR

    // SearchUnit.RUN

    PageType = List;
    SourceTable = "Employee presents";

    Caption = 'Employee Presents';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Employee No."; "Employee No.")
                {
                }
                field(Name; Name)
                {
                }
                field(Description; Description)
                {
                }
                field("Start date"; "Start date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field(Location; Location)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'View Report';
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }

    trigger OnOpenPage();
    begin
        // SearchUnit.RUN;
    end;

    var
    // SearchUnit: Codeunit "Receipts-Post";
}

