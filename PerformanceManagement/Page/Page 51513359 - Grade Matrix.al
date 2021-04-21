page 51513359 "Grade Matrix"
{
    // version HR

    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Appraisal Grades";
    SourceTableView = SORTING ("Lowest Points Awarded")
                      ORDER(Descending);


    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Grade; Grade)
                {
                }
                field(Description; Description)
                {
                }
                field(Remark; Remark)
                {
                }
                field("Lowest Points Awarded"; "Lowest Points Awarded")
                {
                }
                field("Highest Points Awarded"; "Highest Points Awarded")
                {
                }
                field("Salary Increament Perc"; "Salary Increament Perc")
                {
                    Caption = 'Salary Increament Percentage';
                }
            }
        }
    }

    actions
    {
    }
}

