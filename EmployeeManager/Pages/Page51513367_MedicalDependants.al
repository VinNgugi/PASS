page 51513367 "Medical Dependants"
{
    // version HR

    PageType = ListPart;
    SourceTable = "Medical Scheme Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Medical Scheme No";"Medical Scheme No")
                {
                }
                field("Line No.";"Line No.")
                {
                }
                field("Employee Code";"Employee Code")
                {
                }
                field(SurName;SurName)
                {
                }
                field("Policy Start Date";"Policy Start Date")
                {
                }
                field("Other Names";"Other Names")
                {
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    NotBlank = true;
                }
                field(Relationship;Relationship)
                {
                }
                field(Gender;Gender)
                {
                    NotBlank = true;
                }
                field("Amount Spend (In-Patient)";"Amount Spend (In-Patient)")
                {
                }
                field("Amout Spend (Out-Patient)";"Amout Spend (Out-Patient)")
                {
                }
            }
        }
    }

    actions
    {
    }
}

