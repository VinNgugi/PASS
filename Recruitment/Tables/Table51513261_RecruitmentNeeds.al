table 51513261 "Recruitment Needs"
{
    DataClassification = CustomerContent;
    Caption = 'Recruitment Needs';

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            //NotBlank = true;
            Editable = false;

            trigger OnValidate()

            begin
                if "No." <> xRec."No." then begin
                    case "Dept Requisition Type" of
                        "Dept Requisition Type"::"Normal Employment":
                            begin
                                HumanResSetup.GET;
                                NoSeriesMgt.TestManual(HumanResSetup."Recruitment Needs Nos.");
                                "No. Series" := '';
                            end;
                        "Dept Requisition Type"::"AIC Emp":
                            begin
                                HumanResSetup.GET;
                                NoSeriesMgt.TestManual(HumanResSetup."AIC Job Nos.");
                                "No. Series" := '';
                            end;
                    end;

                end;

            end;

        }
        field(2; "Job ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
            TableRelation = if ("Dept Requisition Type" = filter ("Normal Employment")) "Company Jobs"."Job ID" where ("Job Funcion" = filter ("Pass Job"))
            else
            if ("Dept Requisition Type" = filter ("AIC Emp")) "Company Jobs"."Job ID" where ("Job Funcion" = filter ("AIC Job"));

            trigger OnValidate()

            begin
                Jobs.Reset;
                Jobs.SetRange("Job ID", "Job ID");
                If Jobs.Find('-') then begin

                    Jobs.TestField("No. of Posts");

                    case "Dept Requisition Type" of
                        "Dept Requisition Type"::"Normal Employment":
                            begin
                                Description := Jobs."Job Description";
                                Position := Jobs."Vacant Establishments";
                                "Pay Grade" := Jobs.Grade;
                                "Global Dimension 1 Code" := Jobs."Dimension 1";
                                "Global Dimension 2 Code" := Jobs."Dimension 2";
                                "Shortcut Dimension 3 Code" := Jobs."Dimension 3";
                                "Shortcut Dimension 4 Code" := Jobs."Dimension 4";
                                "Shortcut Dimension 5 Code" := Jobs."Dimension 5";
                                "Shortcut Dimension 6 Code" := Jobs."Dimension 6";
                                "Shortcut Dimension 7 Code" := Jobs."Dimension 7";
                                "Shortcut Dimension 8 Code" := Jobs."Dimension 8";
                            end;
                        "Dept Requisition Type"::"AIC Emp":
                            begin
                                Description := Jobs."Incubation Name";
                                "Incubation Name" := Jobs."Incubation Name";
                                "Incubation Code" := Jobs."Job ID";
                                "Incubation Type" := Jobs."Incubation Type";
                                "Incubation Start Date" := Jobs."Incubation Start Date";
                                "Incubation End Date" := Jobs."Incubation End Date";
                                "Incubation Period" := Jobs."Incubation Period";
                                "Global Dimension 1 Code" := Jobs."Dimension 1";
                                "Global Dimension 2 Code" := Jobs."Dimension 2";
                                "Shortcut Dimension 3 Code" := Jobs."Dimension 3";
                                "Shortcut Dimension 4 Code" := Jobs."Dimension 4";
                                "Shortcut Dimension 5 Code" := Jobs."Dimension 5";
                                "Shortcut Dimension 6 Code" := Jobs."Dimension 6";
                                "Shortcut Dimension 7 Code" := Jobs."Dimension 7";
                                "Shortcut Dimension 8 Code" := Jobs."Dimension 8";



                            end;
                    end;


                end;
            end;

        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(4; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(5; Position; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Position';

            trigger OnValidate()

            begin
                If Jobs.Get("Job ID") then begin
                    If Position > Jobs."Vacant Establishments" then
                        Error('%1 tittle has only %2 vacant positions', Jobs."Job Description", Jobs."Vacant Establishments");
                end;
            end;
        }
        field(6; Approved; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved';

            trigger OnValidate()

            begin
                "Date Approved" := Today;
            end;
        }
        field(7; "Date Approved"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Approved';
        }
        field(8; Stage; Code[50])
        {
            //DataClassification = CustomerContent;
            Caption = 'Stage';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
            FieldClass = FlowFilter;
        }
        field(9; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(10; "Stage Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Code';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
        }
        field(11; Qualified; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Qualified';
        }
        field(12; "No Filter"; Integer)
        {
            //DataClassification = CustomerContent;
            Caption = 'No Filter';
            FieldClass = FlowFilter;
        }
        field(13; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(14; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(15; "Documentation Link"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Documentation Link';
        }
        field(16; "Turn Around Time"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Turn Around Time';
            Editable = false;

        }
        field(17; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
            CaptionClass = '1,1,1';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(1, "Global Dimension 1 Code");
            end;
        }
        field(18; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(19; "Reason for Recruitment"; Option)
        {
            OptionMembers = ,"New Position",Replacement,Retirement,Retrenchment,Demise,Other;
            DataClassification = CustomerContent;
            Caption = 'Reason for Recruitment';
        }
        field(20; "Appointment Type"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Appointment Type';
            TableRelation = "Employment Contract";
        }
        field(21; "Requested By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Requested By';
            Editable = false;
            TableRelation = user."User Name";

        }
        field(22; "Expected Reporting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Reporting Date';
        }
        field(23; Status; Option)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
        }
        field(24; "Requisition Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Type';
            OptionMembers = ,Internal,External,Both;
        }
        field(25; "Recruitment Closed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Recruitment Closed';
        }
        field(26; "Closed Applications"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Closed Applications';
        }
        field(27; "Pay Grade"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Pay Grade';
            Editable = false;
        }
        field(28; "Duty Station"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Duty Station';
        }
        field(29; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
            CaptionClass = '1,1,2';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(2, "Global Dimension 2 Code");
            end;
        }
        field(30; "Requester Name"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Requester Name';
            Editable = false;
        }
        field(45; "Short Listing Done?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Short Listing Done?';
        }
        field(49; "In Oral Test"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'In Oral Test';
        }
        field(50; "Past Oral Test"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Past Oral Test';
        }
        field(65; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(80; "In Technical Test"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'In Technical Test';
        }
        field(81; "Passed Technical Test"; Boolean)
        {

        }
        field(82; "In Shortlisting"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'In Shortlisting';
        }
        field(83; "Dept Requisition Type"; Option)
        {
            OptionMembers = "Normal Employment","AIC Emp";
            OptionCaption = 'Normal Employment,AIC Emp';
            DataClassification = CustomerContent;
            Caption = 'Dept Requisition Type';
        }
        field(84; "Incubation Code"; code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(85; "Incubation Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(86; "Incubation Type"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(87; "Incubation Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            caption = 'Incubation Period';
            Editable = false;
        }
        field(89; "Incubation Start Date"; date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(90; "Incubation End Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(91; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));
            CaptionClass = '1,2,3';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(92; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));
            CaptionClass = '1,2,4';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(93; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (5));
            CaptionClass = '1,2,5';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(94; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (6));
            CaptionClass = '1,2,6';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(95; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));
            CaptionClass = '1,2,7';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(96; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (8));
            CaptionClass = '1,2,8';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(97; Shortlisted; Boolean)
        {

        }


    }

    keys
    {
        key(No; "No.")
        {
            Clustered = true;
        }
    }

    var
        Jobs: Record "Company Jobs";
        DimMgt: Codeunit DimensionManagement;
        EmployeeRec: Record Employee;
        HumanResSetup: Record "Human Resources Setup";
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            case "Dept Requisition Type" of
                "Dept Requisition Type"::"Normal Employment":
                    begin
                        HumanResSetup.GET;
                        HumanResSetup.TESTFIELD(HumanResSetup."Recruitment Needs Nos.");
                        NoSeriesMgt.InitSeries(HumanResSetup."Recruitment Needs Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                    end;
                "Dept Requisition Type"::"AIC Emp":
                    begin
                        HumanResSetup.GET;
                        HumanResSetup.TESTFIELD(HumanResSetup."AIC Job Nos.");
                        NoSeriesMgt.InitSeries(HumanResSetup."AIC Job Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                    end;
            end;

        END;
        Date := TODAY;


        "Requested By" := USERID;
        IF UserSetup.GET(USERID) THEN BEGIN
            IF EmployeeRec.GET(UserSetup."Employee No.") THEN BEGIN
                "Requester Name" := EmployeeRec.FullName;
            END;

        END ELSE BEGIN
            ERROR('Contact system Admin to be set up as a valid user.');
        END;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        Error('Not allowed');
    end;

    trigger OnRename()
    begin

    end;

    procedure ValidateShotcutDemCode(FieldNumber: Integer; var ShortcutDimCode: Code[50])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::"Recruitment Needs","No.",FieldNumber,ShortcutDimCode);
        MODIFY;
    end;

}