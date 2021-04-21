page 51513454 "Training Employees"
{
    PageType = ListPart;
    SourceTable = "Training Participants Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employee No."; "Employee No.")
                {

                }
                field("Employee Name"; "Employee Name")
                {

                }
                field("Responsibility Center"; "Responsibility Center")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Training Start Date"; "Training Start Date")
                {

                }
                field("Training End Date"; "Training End Date")
                {

                }
                field("G/l Account"; "G/l Account")
                {

                }
                field("Currency Code"; "Currency Code")
                {
                    /*trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin

                    end;*/

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if "Currency Code" <> '' then
                            LCYVisible := true
                        else
                            LCYVisible := false;
                    end;
                }
                field("Budget Code"; "Budget Code")
                {

                }
                field("Budgeted Amount"; "Budgeted Amount")
                {

                }
                field(Commitment; Commitment)
                {

                }
                field("Per Diem"; "Per Diem")
                {

                }
                field("Per Diem(LCY)"; "Per Diem(LCY)")
                {
                    Visible = LCYVisible;
                }
                field(Accomodation; Accomodation)
                {

                }
                field("Accomodation(LCY)"; "Accomodation(LCY)")
                {
                    Visible = LCYVisible;
                }
                field("Air Ticket Fee"; "Air Ticket Fee")
                {

                }
                field("Air Ticket Fee(LCY)"; "Air Ticket Fee(LCY)")
                {
                    Visible = LCYVisible;
                }
                field("Travel Expences"; "Travel Expences")
                {

                }
                field("Travel Expences(LCY)"; "Travel Expences(LCY)")
                {
                    Visible = LCYVisible;
                }
                field("Net Amount"; "Net Amount")
                {

                }
                field("Net Amount(LCY)"; "Net Amount(LCY)")
                {
                    Visible = LCYVisible;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if "Currency Code" <> '' then
            LCYVisible := true
        else
            LCYVisible := false;
    end;


    var
        LCYVisible: Boolean;
}