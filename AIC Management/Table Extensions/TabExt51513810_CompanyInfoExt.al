tableextension 51513810 "Company Info Ext" extends "Company Information"
{
    fields
    {
        field(50000; "AIC Logo"; Blob)
        {
            Subtype = Bitmap;

        }
        field(50001; "AIC Company Name"; Text[100])
        {

        }
    }
}