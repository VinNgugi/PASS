page 51513220 "Staff Categories"
{
    PageType = List;
    SourceTable = "Employee Type";
    Caption = 'Staff Categories';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Group"; "Posting Group")
                {
                }
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Salary Scale Filter"; "Salary Scale Filter")
                {
                }
            }
        }
    }


}

