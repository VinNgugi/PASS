table 51513302 "HR Journal Line"
{
    // version HR

    Caption = 'HR Journal Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            TableRelation = "HR Leave Journal Template".Name;
        }
        field(2; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "HR Leave Journal Batch".Name;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; "Leave Period"; Code[20])
        {
            Caption = 'Leave Period';
            TableRelation = "HR Leave Periods"."Period Code" WHERE (Closed = CONST (false));

            trigger OnValidate();
            begin
                /*IF "Leave Application No." = '' THEN BEGIN
                  CreateDim(DATABASE::Table5628,"Leave Application No.");
                  EXIT;
                END;
                
                HR.GET("Leave Application No.");
                //HR.TESTFIELD(Blocked,FALSE);
                Description := HR.Description;
                "Leave Approval Date":=HR."HOD Start Date";
                "No. of Days":=HR."HOD Approved Days";
                "Leave Type Code":=HR."Leave Code";
                CreateDim(DATABASE::Table5628,"Leave Application No.");
                  */

            end;
        }
        field(6; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                if "Staff No." = '' then begin
                    "Staff Name" := '';
                    exit;
                end;
                HREmp.GET("Staff No.");
                "Staff Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(7; "Staff Name"; Text[120])
        {
            Caption = 'Staff Name';
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(9; "Leave Entry Type"; Option)
        {
            Caption = 'Leave Entry Type';
            Editable = true;
            OptionCaption = 'Positive,Negative,Reimbursement';
            OptionMembers = Positive,Negative,Reimbursement;
        }
        field(10; "Leave Approval Date"; Date)
        {
            Caption = 'Leave Approval Date';
            Editable = false;
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(12; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(13; "No. of Days"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'No. of Days';
            Editable = true;

            trigger OnValidate();
            begin
                if LeaveType.GET("Leave Type") then begin
                    //IF (LeaveType."Fixed Days"=TRUE) THEN BEGIN
                    if "No. of Days" > LeaveType.Days then
                        ERROR(Text001, "Leave Type");

                    //END;
                end;
            end;
        }
        field(14; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

            trigger OnValidate();
            begin
                /*ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
                MODIFY;
                */

            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

            trigger OnValidate();
            begin
                /*ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
                MODIFY;*/

            end;
        }
        field(17; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(18; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(20; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(21; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(22; "Leave Type"; Code[20])
        {
            Editable = true;
            TableRelation = "Leave Types".Code;

            trigger OnValidate();
            begin
                //   IF HRLeaveTypes.GET("Leave Type") THEN
                //  "No. of Days":=HRLeaveTypes.Days;
            end;
        }
        field(23; "Leave Recalled No."; Code[20])
        {
            Caption = 'Leave Application No.';
            TableRelation = "Employee Leave Application"."Application No" WHERE (Status = FILTER (Approved),
                                                                                 Post = FILTER (true),
                                                                                 "Employee No" = FIELD ("Staff No."));

            trigger OnValidate();
            begin
                /*IF "Document No." = '' THEN BEGIN
                  CreateDim(DATABASE::Table5628,"Leave Application No.");
                  EXIT;
                END;
                
                HR.GET("Leave Application No.");
                //HR.TESTFIELD(Blocked,FALSE);
                Description := HR.Description;
                "Leave Approval Date":=HR."HOD Start Date";
                "No. of Days":=HR."HOD Approved Days";
                "Leave Type Code":=HR."Leave Code";
                CreateDim(DATABASE::Table5628,"Leave Application No.");
                */

            end;
        }
        field(26; "Leave Period Start Date"; Date)
        {

            trigger OnValidate();
            begin


                //"Leave Period End Date":=CALCDATE('-1D',CALCDATE('12M',"Leave Period Start Date"));
            end;
        }
        field(27; "Leave Period End Date"; Date)
        {
        }
        field(28; "Positive Transaction Type"; Option)
        {
            OptionCaption = '" ,Leave Allocation,Leave Recall,OverTime"';
            OptionMembers = " ","Leave Allocation","Leave Recall",OverTime;
        }
        field(29; "Negative Transaction Type"; Option)
        {
            OptionCaption = '" ,Leave Taken,Leave Forfeited "';
            OptionMembers = " ","Leave Taken","Leave Forfeited ";
        }
        field(30; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';

            trigger OnValidate();
            begin
                if "Leave Application No." = '' then begin
                    CreateDim(DATABASE::"Employee Leave Application", "Leave Application No.");
                    exit;
                end;
                HRLeaveApp.RESET;
                HRLeaveApp.SETRANGE(HRLeaveApp."Application No", "Leave Application No.");
                if HRLeaveApp.FIND('-') then begin
                    //HRLeaveApp.GET("Leave Application No.");
                    //HRLeaveApp.TESTFIELD(Blocked,FALSE);
                    //Description := HRLeaveApp."Applicant Comments";
                    "Leave Approval Date" := HRLeaveApp."Start Date";
                    "No. of Days" := HRLeaveApp."Approved Days";
                    "Leave Type" := HRLeaveApp."Leave Code";
                end;
                CreateDim(DATABASE::"Employee Leave Application", "Leave Application No.");
            end;
        }
        field(31; "Claim Type"; Option)
        {
            OptionMembers = Inpatient,Outpatient;
        }
        field(32; Amount; Integer)
        {
        }
        field(33; "Credited Back"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Allocation,Carry Forward,Credit Back,Leave Recall,Leave Applied,Reversal';
            OptionMembers = " ",Allocation,"Carry Forward","Credit Back","Leave Recall","Leave Applied",Reversal;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date")
        {
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        /*DimMgt.DeleteJnlLineDim(
          DATABASE::"HR Journal Line",
          "Journal Template Name","Journal Batch Name","Line No.",0);
            */

    end;

    trigger OnInsert();
    begin
        //JnlLineDim.LOCKTABLE;
        //LOCKTABLE;
        HRJnlTempl.GET("Journal Template Name");
        "Source Code" := HRJnlTempl."Source Code";
        HRJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        "Reason Code" := HRJnlBatch."Reason Code";

        ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
        /*
        DimMgt.InsertJnlLineDim(
          DATABASE::"HR Journal Line",
          "Journal Template Name","Journal Batch Name","Line No.",0,
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        
        */
        SetUpNewLine(Rec);

        /*HR.RESET;
        IF HR.FIND('-') THEN BEGIN
        "Leave Period Start Date":=HR."Leave Posting Period[FROM]";
        "Leave Period End Date":=HR."Leave Posting Period[TO]";
        END;
        VALIDATE("Leave Period Start Date");
        VALIDATE("Leave Period End Date");  */

    end;

    var
        HRLeaveApp: Record "Employee Leave Application";
        HREmp: Record Employee;
        HRJnlTempl: Record "HR Leave Journal Template";
        HRJnlBatch: Record "HR Leave Journal Batch";
        HRJnlLine: Record "HR Journal Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        LeaveType: Record "Leave Types";
        Text001: Label 'You can not post more than maximum days allowed for this leave type %1';
        LeavePeriod: Record "Payroll Period";
        HRLeaveTypes: Record "Multi- Comp Leave Types";
        HR: Record "Human Resources Setup";

    procedure SetUpNewLine(LastHRJnlLine: Record "HR Journal Line");
    begin
        HRJnlTempl.GET("Journal Template Name");
        HRJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        HRJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        HRJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        if HRJnlLine.FIND('-') then begin
            "Posting Date" := LastHRJnlLine."Posting Date";
            "Document No." := LastHRJnlLine."Document No.";
        end else begin
            //"Posting Date" := WORKDATE;
            if HRJnlBatch."No. Series" <> '' then begin
                CLEAR(NoSeriesMgt);
                "Document No." := NoSeriesMgt.TryGetNextNo(HRJnlBatch."No. Series", "Posting Date");
            end;
        end;
        "Source Code" := HRJnlTempl."Source Code";
        "Reason Code" := HRJnlBatch."Reason Code";
        "Posting No. Series" := HRJnlBatch."Posting No. Series";
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]);
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        /*TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        DimMgt.GetDefaultDim(
          TableID,No,"Source Code",
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        IF "Line No." <> 0 THEN
          DimMgt.UpdateJnlLineDefaultDim(
            DATABASE::Table5635,
            "Journal Template Name","Journal Batch Name","Line No.",0,
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
          */

    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        /*DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        IF "Line No." <> 0 THEN BEGIN
          DimMgt.SaveJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode);
          IF MODIFY THEN;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
         */

    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        /*DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        IF "Line No." <> 0 THEN BEGIN
          DimMgt.SaveJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode);
          MODIFY;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */

    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        /*IF "Line No." <> 0 THEN
          DimMgt.ShowJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,ShortcutDimCode)
        ELSE
          DimMgt.ShowTempDim(ShortcutDimCode);
        */

    end;

    procedure ValidateOpenPeriod(LeavePeriod: Record "Payroll Period");
    var
        Rec1: Record "Payroll Period";
    begin
        /*WITH LeavePeriod DO
        BEGIN
         Rec1.RESET;
        IF Rec1.FIND('-')THEN BEGIN
        "Leave Period Start Date":=Rec1."Starting Date";
        VALIDATE("Leave Period Start Date");    `
        END;
        END;*/

    end;
}

