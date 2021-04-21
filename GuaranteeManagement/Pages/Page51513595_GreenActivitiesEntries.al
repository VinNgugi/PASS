page 51513595 "Green Activities Entries"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Green Activities Entries";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field(Checkbox; Checkbox)
                {

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {

        }
    }
    var
        ObjGreenSetup: Record "Green Activities Setup";
        ObjGreenEntries: Record "Green Activities Entries";
}