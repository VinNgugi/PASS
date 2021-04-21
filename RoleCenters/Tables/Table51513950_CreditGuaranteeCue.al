table 51513950 "Credit Guarantee Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "OpenGuaranteeApplications"; Integer)
        {
            Caption = 'Open';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Application" where (Status = filter (Open), "Created By" = field ("User Filter")));
        }

        field(3; "PendingGuaranteeApplications"; Integer)
        {
            Caption = 'Pending Approval';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Application" where (Status = filter ("Pending Approval"), "Created By" = field ("User Filter")));
        }
        field(4; "PreAppraisalStage"; Integer)
        {
            Caption = 'Pre - Appraisal';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Application" where (Status = filter (Released), "Application Status" = FILTER (" " | "Commitment Paid"), "Created By" = field ("User Filter")));
        }

        field(5; "ContractPreparationStage"; Integer)
        {
            Caption = 'Contract Preparation';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Application" where ("Application Status" = FILTER ("Pre-Appraised"), "Created By" = field ("User Filter")));
        }
        field(6; "ContractSigningStage"; Integer)
        {
            Caption = 'Contract Signing';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Application" where ("Application Status" = FILTER ("Contract Prepared"), "Created By" = field ("User Filter")));
        }

        field(7; "BusinessPlanStage"; Integer)
        {
            Caption = 'Business Plan - Preparation';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Contracts" where ("Contract Status" = FILTER ("BP in Progress"), "BP sent for review" = filter (false)));
        }

        field(8; "BPPendingQA"; Integer)
        {
            Caption = 'Business Plan - QA';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Contracts" where ("Contract Status" = FILTER ("BP in Progress"), "BP Reviewed" = const (true)));
        }

        field(9; "User Filter"; Code[50])
        {
            FieldClass = FlowFilter;

        }
        field(10; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }

        field(12; "Requests to Approve"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Approval Entry" WHERE ("Approver ID" = FIELD ("User Filter"), Status = FILTER (Open)));
        }
        field(13; "BPunderReview"; Integer)
        {
            Caption = 'Business Plan- Review';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Contracts" where ("Contract Status" = FILTER ("BP in Progress"), "BP sent for review" = const (true)));
        }
        field(14; "My Approval Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Approval Entry" WHERE ("Sender ID" = FIELD ("User Filter"), Status = FILTER (Open)));
        }
        field(15; "BPWithBank"; Integer)
        {
            Caption = 'Business Plan - With Banks';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Contracts" where ("Contract Status" = FILTER ("BP with Bank")));
        }
        field(16; "ApprovedLoans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Contracts" where ("Contract Status" = FILTER ("Loan Granted")));
        }

        field(17; "CGCPrepared"; Integer)
        {
            Caption = 'CGC - Preparation';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Contracts" where ("Contract Status" = filter ("CGC Prepared")));
        }
        field(18; "IssuedCGC"; Integer)
        {
            Caption = 'Issued CGCs';
            FieldClass = FlowField;
            CalcFormula = count ("Guarantee Contracts" where ("Contract Status" = filter ("CGC Issued")));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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