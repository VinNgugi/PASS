page 51513338 "Court Cases"
{
    // version HR
    Caption = 'Court Cases';
    CardPageID = "Disciplinary Cases Card";
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Disciplinary Cases";
    SourceTableView = WHERE ("Case Status" = CONST (Court));

    layout
    {
        area(content)
        {
            repeater(General)
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
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Case Status"; "Case Status")
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
    }

    actions
    {
    }
}

