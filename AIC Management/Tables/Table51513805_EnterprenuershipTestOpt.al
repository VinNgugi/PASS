table 51513805 "Enterprenuership Test Options"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Test Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Option Code"; Code[20])
        {
            Editable = false;
        }
        field(3; "Option Text"; Text[1000])
        {

        }
        field(4; "Weighted Score"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Test Code", "Option Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        TestOptions: Record "Enterprenuership Test Options";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        TotalOptions: Integer;
        NextEntry: Integer;


    trigger OnInsert()
    begin
        IF "Option Code" = '' then begin
            NextEntry := 0;
            TestOptions.Reset();
            TestOptions.SetRange("Test Code", "Test Code");
            if TestOptions.FindSet() then
                TotalOptions := TestOptions.Count;

            if (TotalOptions = 0) then
                "Option Code" := "Test Code" + '/' + Format(1)
            else begin
                NextEntry := TotalOptions + 1;
                "Option Code" := "Test Code" + '/' + Format(NextEntry);
            end;


        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}