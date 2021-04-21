table 51513300 "HR Leave Journal Batch"
{
    // version HR
    Caption = 'HR Leave Journal Batch';
    DataClassification = CustomerContent;
    DataCaptionFields = Name, Description;
    DrillDownPageID = "HR Leave Batches";
    LookupPageID = "HR Leave Batches";

    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "HR Leave Journal Template";
        }
        field(2; Name; Code[20])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";

            trigger OnValidate();
            begin
                if "Reason Code" <> xRec."Reason Code" then begin
                    HRJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    HRJnlLine.SETRANGE("Journal Batch Name", Name);
                    HRJnlLine.MODIFYALL("Reason Code", "Reason Code");
                    MODIFY;
                end;
            end;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate();
            begin
                if ("No. Series" <> '') and ("No. Series" = "Posting No. Series") then
                    VALIDATE("Posting No. Series", '');
            end;
        }
        field(6; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate();
            begin
                if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
                    FIELDERROR("Posting No. Series", STRSUBSTNO(Text000, "Posting No. Series"));
                HRJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                HRJnlLine.SETRANGE("Journal Batch Name", Name);
                HRJnlLine.MODIFYALL("Posting No. Series", "Posting No. Series");
                MODIFY;
            end;
        }
        field(18; Type; Option)
        {
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive,Negative;

            trigger OnValidate();
            begin
                /*
                //"Test Report ID" := REPORT::"General Journal - Test";
                //"Posting Report ID" := REPORT::"G/L Register";
                SourceCodeSetup.GET;
                CASE Type OF
                  Type::Positive:
                    BEGIN
                      "Source Code" := SourceCodeSetup."Leave Journal";
                      "Form ID" :=  PAGE::"HR Leave Journal Lines";
                    END;
                  Type::Negative:
                    BEGIN
                      "Source Code" := SourceCodeSetup."Leave Journal";
                      "Form ID" := PAGE::"HR Leave Journal Lines";
                    END;
                END;
                */

            end;
        }
        field(19; "Posting Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        HRJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        HRJnlLine.SETRANGE("Journal Batch Name", Name);
        HRJnlLine.DELETEALL(true);
    end;

    trigger OnInsert();
    begin
        LOCKTABLE;
        HRJnlTemp.RESET();
        "Journal Template Name" := HRJnlTemp.Name;
    end;

    trigger OnRename();
    begin
        HRJnlLine.SETRANGE("Journal Template Name", xRec."Journal Template Name");
        HRJnlLine.SETRANGE("Journal Batch Name", xRec.Name);
        while HRJnlLine.FIND('-') do
            HRJnlLine.RENAME("Journal Template Name", Name, HRJnlLine."Line No.");
    end;

    var
        Text000: Label 'must not be %1';
        HRJnlTemp: Record "HR Leave Journal Template";
        HRJnlLine: Record "HR Journal Line";

    procedure SetupNewBatch();
    begin
        HRJnlTemp.GET("Journal Template Name");
        "No. Series" := HRJnlTemp."No. Series";
        "Posting No. Series" := HRJnlTemp."Posting No. Series";
        "Reason Code" := HRJnlTemp."Reason Code";
    end;
}

