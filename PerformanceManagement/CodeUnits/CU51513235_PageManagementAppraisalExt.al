codeunit 51513235 "Page Management Appraisal Ext"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef)
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin

        CASE RecordRef.Number of
            DATABASE::"Employee Appraisal Objectives":
                exit(Page::"Employee Appraisal Objectives_");
            Database::"Employee Appraisals":
                exit(Page::"Appraisal Form");


        end;
    end;

}