table 51513322 "Claim Line"
{
    // version HR

    //DrillDownPageID = 51511283;
    //LookupPageID = 51511283;
    Caption = 'Claim Line';
    fields
    {
        field(1; "Claim No"; Code[20])
        {
            Caption = 'Claim No';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Claimheader.RESET;
                Claimheader.GET("Claim No");
                "Fiscal Year" := Claimheader."Fiscal Year";
            end;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(3; "Patient No"; Integer)
        {
            Caption = 'Patient No';
            DataClassification = CustomerContent;
            TableRelation = "Medical Scheme Lines"."Line No."; //WHERE ("Employee Code" = FIELD ("Employee No"),
                                                               //"Fiscal Year" = FIELD ("Fiscal Year"));

            trigger OnValidate();
            begin
                TESTFIELD("Visit Date");
                MedSchemeLines.RESET;
                MedSchemeLines.SETRANGE(MedSchemeLines."Employee Code", "Employee No");
                MedSchemeLines.SETFILTER(MedSchemeLines."Line No.", '%1', "Patient No");
                if MedSchemeLines.FIND('+') then
                    "Patient Name" := MedSchemeLines."Other Names" + ' ' + MedSchemeLines.SurName;
                Relationship := MedSchemeLines.Relationship;
            end;
        }
        field(4; "Patient Name"; Text[80])
        {
            Caption = 'Patient Name';
            DataClassification = CustomerContent;
        }
        field(5; "Hospital/Specialist"; Text[250])
        {
            Caption = 'Hospital/Specialist';
            DataClassification = CustomerContent;
        }
        field(6; "Invoice Number"; Code[20])
        {
            Caption = 'Invoice Number';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                claims.RESET;
                claims.SETRANGE(claims."Claim No", "Claim No");
                claims.SETRANGE(claims."Employee No", "Employee No");
                if claims.FIND('-') then begin
                    if claims."Invoice Number" = "Invoice Number" then
                        ERROR('That Invoice number has already been captured!');
                end;
            end;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Approved Amount" := Amount;
                MedicalSheme.RESET;
                MedicalSheme.SETRANGE(MedicalSheme."Employee No", "Employee No");
                MedicalSheme.SETRANGE("Fiscal Year", "Fiscal Year");
                if MedicalSheme.FIND('+') then begin
                    if "Claim Type" = "Claim Type"::"In Patient" then begin
                        MedicalSheme.CALCFIELDS(MedicalSheme."In-Patient Claims", MedicalSheme."Out-Patient Claims");
                        if Amount + MedicalSheme."In-Patient Claims" > MedicalSheme."Entitlement -Inpatient" then
                            MESSAGE('By Accepting this claim you will be exceed the in-patient limit');
                    end;
                    if "Claim Type" = "Claim Type"::"Out Patient" then begin
                        if Amount + MedicalSheme."Out-Patient Claims" > MedicalSheme."Entitlement -OutPatient" then
                            MESSAGE('By Accepting this claim you will be exceed the out-patient limit');
                    end;

                end;
            end;
        }
        field(8; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = CustomerContent;

            TableRelation = Employee WHERE (Status = FILTER (Active));

            trigger OnValidate();
            begin
                if emp.GET("Employee No") then
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(10; "Medical Scheme"; Code[20])
        {
            Caption = 'Medical Scheme';
            DataClassification = CustomerContent;
        }
        field(11; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Approved,Rejected,"Part Payment";
        }
        field(12; "Amount Spend (In-Patient)"; Decimal)
        {
            Caption = 'Amount Spend (In-Patient)';
            CalcFormula = Sum ("Claim Line"."Approved Amount" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                    "Patient No" = FIELD ("Patient No"),
                                                                    "Claim Type" = CONST ("In Patient")));
            FieldClass = FlowField;
        }
        field(13; "Amout Spend (Out-Patient)"; Decimal)
        {
            Caption = 'Amout Spend (Out-Patient)';
            CalcFormula = Sum ("Claim Line"."Approved Amount" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                    "Patient No" = FIELD ("Patient No"),
                                                                    "Claim Type" = CONST ("Out Patient")));
            FieldClass = FlowField;
        }
        field(14; "Claim Type"; Option)
        {
            Caption = 'Claim Type';
            DataClassification = CustomerContent;
            OptionCaption = '" ,In Patient,Out Patient,Dental,Optical"';
            OptionMembers = " ","In Patient","Out Patient",Dental,Optical;
        }
        field(15; "Balance (In-Patient)"; Decimal)
        {
            Caption = 'Balance (In-Patient)';
            DataClassification = CustomerContent;
        }
        field(16; "Balance (Out-Patient)"; Decimal)
        {
            Caption = 'Balance (Out-Patient)';
            DataClassification = CustomerContent;
        }
        field(17; "Visit Date"; Date)
        {
            Caption = 'Visit Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                AccountingP.RESET;
                AccountingP.SETRANGE(AccountingP."Starting Date", 0D, "Visit Date");
                AccountingP.SETRANGE(AccountingP."New Fiscal Year", true);
                if AccountingP.FIND('+') then
                    "Policy Start Date" := AccountingP."Starting Date";
            end;
        }
        field(18; "Employee Name"; Text[80])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(19; Relationship; Code[20])
        {
            Caption = 'Relationship';
            DataClassification = CustomerContent;
            TableRelation = "Medical Scheme Header";
        }
        field(21; "Policy Start Date"; Date)
        {
            Caption = 'Policy Start Date';
            DataClassification = CustomerContent;

        }
        field(22; "Commissioner Code"; Code[30])
        {
            Caption = 'Commissioner Code';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                dimvalue.RESET;
                if dimvalue.GET('COMMISSIONERS', "Commissioner Code") then
                    "Commissioner Name" := dimvalue.Name;
            end;
        }
        field(23; "Commissioner Name"; Text[50])
        {
            Caption = 'Commissioner Name';
            DataClassification = CustomerContent;
        }
        field(24; Settled; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Settled';
        }
        field(25; "Cheque No"; Code[20])
        {
            Caption = 'Cheque No';
            DataClassification = CustomerContent;
        }
        field(26; Directorate; Code[10])
        {
            Caption = 'Directorate';
            DataClassification = CustomerContent;
        }
        field(27; Department; Code[10])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(28; "Fiscal Year"; Code[40])
        {
            Caption = 'Fiscal Year';
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name";
        }
    }

    keys
    {
        key(Key1; "Claim No", "Line No")
        {
        }
        key(Key2; "Claim Type", "Employee No", "Patient No", "Policy Start Date")
        {
            SumIndexFields = "Approved Amount", Amount;
        }
    }

    fieldgroups
    {
    }

    var
        MedSchemeLines: Record "Medical Scheme Lines";
        MedicalSheme: Record "Medical Scheme Header";
        AccountingP: Record "Accounting Period";
        emp: Record Employee;
        claims: Record "Claim Line";
        dimvalue: Record "Dimension Value";
        Claimheader: Record "Medical Claim Header";
}

