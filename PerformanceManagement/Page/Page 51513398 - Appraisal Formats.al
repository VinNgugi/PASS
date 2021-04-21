page 51513398 "Appraisal Formats"
{
    // version HR

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Formats";
    SourceTableView = SORTING ("Appraisal Code", Sequence)
                      ORDER(Ascending);
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Appraisal Heading Type"; "Appraisal Heading Type")
                {
                }
                field(Type; Type)
                {
                    Visible = false;
                }
                field("Code"; Code)
                {
                    Visible = false;
                }
                field(Sequence; Sequence)
                {
                    Visible = false;
                }
                field(Value; Value)
                {
                }
                field(Bold; Bold)
                {
                }
                field(Description; Description)
                {
                }
                field("In Put"; "In Put")
                {
                }
                field("Entry By"; "Entry By")
                {
                }
                field("After Entry Of Prev. Group"; "After Entry Of Prev. Group")
                {
                }
                field("Allow Previous Groups Rights"; "Allow Previous Groups Rights")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        ValueOnFormat;
    end;

    var
        [InDataSet]
        ValueEmphasize: Boolean;

    local procedure ValueOnFormat();
    begin

        if Bold then
            ValueEmphasize := true;
    end;
}

