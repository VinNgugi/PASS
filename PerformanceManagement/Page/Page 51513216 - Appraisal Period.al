page 51513216 "Appraisal Period"
{
    PageType = Card;
    SourceTable = "Appraisal Periods";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Period; Period)
                {
                }
                field(Comments; Comments)
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
            }
            part(Control9; "PAR Results")
            {
                SubPageLink = "Appraisal Period" = FIELD (Period);
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            //Caption = 'Actions';
            action("Import Results")
            {
                Caption = 'Import Results';

                trigger OnAction();
                begin
                    Importer.GetRec(Rec);
                    Importer.RUN;
                end;
            }
        }
    }

    var
        Importer: XMLport "Import PAR";
}

