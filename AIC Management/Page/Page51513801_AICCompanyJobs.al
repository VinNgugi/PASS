page 51513801 "AIC Company Jobs"
{
    PageType = Card;

    SourceTable = "Company Jobs";
    SourceTableView = order(ascending) where ("Job Funcion" = filter ("AIC Job"));
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Job ID"; "Job ID")
                {
                    Caption = 'Incubation No.';
                }
                field("Incubation Name"; "Incubation Name")
                {

                }
                field("Incubation Type"; "Incubation Type")
                {
                    Visible = false;
                }
                field("Incubation Start Date"; "Incubation Start Date")
                {

                }
                field("Incubation Period"; "Incubation Period")
                {

                }
                field("Incubation End Date"; "Incubation End Date")
                {

                }

                field(Status; Status)
                {

                }
            }
            group("Dimension Values")
            {
                field("Dimension 1"; "Dimension 1")
                {

                }
                field("Dimension 2"; "Dimension 2")
                {

                }

            }
            part("Subsector & Busines Type"; "Subsector & Business Type")
            {
                SubPageLink = "Job ID" = field ("Job ID");
            }
        }
    }



    trigger OnAfterGetRecord()

    begin
        OnAfterGetCurrRecord1;
    end;

    trigger OnNewRecord(BelowRec: Boolean)

    begin
        OnAfterGetCurrRecord1;
        "Job Funcion" := "Job Funcion"::"AIC Job";
    end;

    local procedure OnAfterGetCurrRecord1()

    begin
        xRec := Rec;
        IF "No. of Posts" <> xRec."No. of Posts" THEN
            "Vacant Establishments" := "No. of Posts" - "Occupied Establishments";

    end;
}