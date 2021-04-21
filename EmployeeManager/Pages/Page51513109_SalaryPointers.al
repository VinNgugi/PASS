page 51513109 "Salary Pointers"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Salary Pointers";
    Caption = 'Salary Pointers';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Salary Pointer"; "Salary Pointer")
                {
                }
                field("Basic Pay"; "Basic Pay")
                {
                }
                field("Basic Pay int"; "Basic Pay int")
                {
                }
            }
        }
    }

    /*  actions
      {
          area(navigation)
          {
              group(Benefits)
              {
                  Caption = 'Benefits';
                  action(Earnings)
                  {
                      Caption = 'Earnings';
                      RunObject = Page "Scale Benefits";
                      RunPageLink = "Salary Scale" = FIELD (Field4),
                                    "Salary Pointer" = FIELD ("Salary Pointer");
                  }
              }
          }
      }*/
}

