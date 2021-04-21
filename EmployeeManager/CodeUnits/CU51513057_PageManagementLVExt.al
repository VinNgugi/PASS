codeunit 51513057 "Page Management LVExt"
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
            DATABASE::"Employee Leave Application":
                exit(Page::"Leave Application HR");
            Database::"Leave Recall":
                exit(Page::"Leave Recall");


        end;
    end;

}