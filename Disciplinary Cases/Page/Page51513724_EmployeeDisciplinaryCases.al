page 51513724 "Employee Disciplinary Cases"
{
    PageType = List;
    SourceTable = "Disciplinary Cases";
    Caption = 'Employee Disciplinary Cases';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Case No"; "Case No")
                {
                }
                field("Case Description"; "Case Description")
                {
                }
                field("Date of the Case"; "Date of the Case")
                {
                }
                field("Offense Type"; "Offense Type")
                {
                }
                field("Offense Name"; "Offense Name")
                {
                }
                field("Case Status"; "Case Status")
                {
                }
                field("HOD Name"; "HOD Name")
                {
                }
                field("HOD Recommendation"; "HOD Recommendation")
                {
                }
                field("HR Recommendation"; "HR Recommendation")
                {
                }
                field("Commitee Recommendation"; "Commitee Recommendation")
                {
                }
                field("Action Taken"; "Action Taken")
                {
                }
                field(Appealed; Appealed)
                {
                }
                field("Committee Recon After Appeal"; "Committee Recon After Appeal")
                {
                }
            }
        }
        area(Factboxes)
        {

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
}