page 51513362 "Competency/CoreSkills-Setup"
{
    // version HR

    PageType = List;
    SourceTable = "Competencies/Core Skills-Setup";
    Caption = 'Competency/CoreSkills-Setup';
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Competency Code"; "Competency Code")
                {
                }
                field(Competencies; Competencies)
                {
                }
                field(Description; Description)
                {
                }
                field(Type; Type)
                {
                }
            }
        }
    }

    actions
    {
    }
}

