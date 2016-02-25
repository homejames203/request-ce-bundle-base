

// Function called when a table needs to be built. Pass the following parameters
    // sectionWithQuestionDivClass - Add a style class to the section that contains the questions we want to show in the table
    // questionForJSON - this is the menu label for the question on the SI that stores the JSON string
    // tableDivID - create a text element on the page that you'll be displaying a table and give it an ID. Pass that ID here...
    // tableNameForOneOffs - pass a unique name for this table so you can handle oneoffs downstream 
function loadData(sectionWithQuestions, questionForJSON, tableDivID, tableNameForOneOffs) {

    // Define Variables
    var oTable;                            // Table Variable
    var columns = [];                      // Variable used to store the column names
    var tableDiv = $('#' + tableDivID);    // jQuery table div selector
    var jsonData = [];                     // Array or entries in table
    var tableName = tableNameForOneOffs;
    var sectionWithQuestions = K('section[' + sectionWithQuestions + ']') ; // Div Class of the section that contains the questions (we show and hide this section)
    var innerTableDiv = tableDivID +"_Table";
    var allowDeleteClone = true;
    var jsonQuestionName = questionForJSON; // Assign the question name used to store the JSON string
    
    // Loop through all of the questions in the section passed and grab the question labels. These will be used to build the columns
    // in the table as well as update the questionAnswers when adding and modifying rows    
    columns = $(sectionWithQuestions.element()).find( 'div[data-element-type="wrapper"]' ).map(function() {
        return {'Name' : $(this).data("element-name"), 'Title' : $(this).children('label.field-label').html()};
    });

    // Add the last column which has the row manipulator buttons (Edit, Clone, Delete, Save, Cancel Save)
    columns.push({"title": '',
             "width": '20px',
             "data" :  null,
             "defaultContent": "<button title= 'Remove Item' class='btn-delete' value='Delete'><i class='fa fa-times'></i></button> ",
             "orderable": false
            });
    


    /**********************************
    CUSTOM CODE SPECIFIC TO PROJECT
    **********************************/

    /**********************************
    END CUSTOM CODE SPECIFIC TO PROJECT
    **********************************/
   

    // Check to see if there is already Table Data from a saved request
    if (K('field['+ jsonQuestionName +']').value() != null && K('field['+ jsonQuestionName +']').value() != "[]"){
        // Parse the question value string into a json array
        jsonData = JSON.parse(K('field['+ jsonQuestionName +']').value());
        // Create an Array of Data that the Data Table can accept
        var dataSetArray = [];
        for(var i = 0; i < jsonData.length; i++){
            var keyArray = Object.keys(jsonData[i]);
            var resultArray = [];
                for(var j = 0; j < keyArray.length; j++){
                    resultArray.push(jsonData[i][keyArray[j]]);
                }
            dataSetArray.push(resultArray);
        }
        buildDataTable(dataSetArray);
    }
    // If no data exists, build an empty table
    else {
        buildDataTable([]);
    }

    // Function the builds the actual Data Table
    function buildDataTable(dataArray) {
        //Destroy first, if the table already exists.
        if (oTable){
            oTable.destroy();
        }
       
        /* Add table container and definition to container div */
       tableDiv.html('<div class="toolbar"></div>').append('<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"display\" id=\"'+ innerTableDiv+'\"></table>' );
        oTable = $('#'+innerTableDiv).DataTable({
            "data": dataArray,
            "columns" : columns,
            "pageLength": 5,
            "lengthChange": true,
            "searching": false,
            "scrollX": true,
            "bLengthChange": false
        });

        // Append an add button and a save button
        //if(clientManager.submitType != "ReviewRequest" && allowDeleteClone == true){
            tableDiv.append($("<div id='action-btns' style='padding-top:15px;'>" +
                    "<button name='Add " + tableName + "' id='action-btn-create' class='btn-create' value='addButton' style='margin-right: 10px;'>Add a New " + tableName + "</button>" +
                    "<button name='Save " + tableName + "' id='action-btn-save' class='btn-save' value='saveButton' style='display:none; margin-right: 10px;'>Save " + tableName + " to Table</button>"+
                    "<button name='Cancel' id='action-btn-cancel' class='btn-cancel' value='cancelButton' style='display:none; margin-right: 10px;' >Cancel</button>"));
        //}

         //Append table header (tableName)
         $("div.toolbar").html('<h4>' + tableName + '</h4>');
        
        //watch for add button click on Table Buttons (action-btns div)
        $('#action-btns').on( 'click', 'button', function () {
            if (this.value==="addButton") {
                sectionWithQuestions.show();
                $('#action-btn-save').show();
                $('#action-btn-cancel').show();
                $('#action-btn-create').hide();
                $('.templateButton').hide();
            }

            if (this.value==="cancelButton") {
                sectionWithQuestions.hide();
                //$('#action-btn-save').hide();
                $('#action-btn-cancel').hide();
                $('#action-btn-create').show();
                $('.templateButton').show();
                //for (var i = 0; i < questions.length; i++){
                //    KD.utils.Action.setQuestionValue(questions[i],"");
                //}
            }

            if (this.value==="saveButton") {            
                // temp variable for new table row
                var newRow = [];
                // temp variable for building JSON object to be pushed to jsonData array
                var newRowJSON = {};
                // temp value to validate data
                var allowSave = true;
                /*var serverName = KD.utils.Action.getQuestionValue(questions[0]);

                if(serverName != ""){
                    for (var i = 0; i < jsonData.length; i ++){
                        if (jsonData[i]['Server Name'] == serverName) {
                            allowSave = false;
                            alert("Server Name must be unique. Please update values and try again.");
                        }
                    }
                }
                else{
                    allowSave = false;
                    alert("Server Name can not be blank. Please update values and try again.");
                }*/

                if(allowSave){
                    // loop through each question and build up temp variables, also blank out questions 
                    for (var i = 0; i < columns.length -1; i++){              
                        newRowJSON[columns[i].Name]=K('field['+ columns[i].Name +']').value();
                        newRow.push(K('field['+ columns[i].Name +']').value());
                        K('field['+ columns[i].Name +']').value(null);                    
                    }
                    // push temp json object to jsonData array
                    jsonData.push(newRowJSON);
                    // set the json question on the Service Item which ultimately saves the data
                    K('field['+ jsonQuestionName +']').value(JSON.stringify(jsonData) );
                    // add the new row to the table
                    oTable.row.add(newRow).draw();
                    $('#action-btn-save').hide();
                    sectionWithQuestions.hide();
                    $('#action-btn-create').show();
                    $('#action-btn-cancel').hide();
                    $('.templateButton').show();
                }
            }
        });

        
        //watch for in-table button clicks
        $('table tbody', tableDiv).on( 'click', 'button', function () {
            var row = $(this).parents('tr'),
                index = oTable.row( row ).index(),
                data = oTable.row( row ).data();
                var rowIdentifier;
                for(var j = 0; j < jsonData.length; j++){
                    if (jsonData[j][columns[0].name] == data[0]){
                        rowIdentifier = j;
                    }
                }
                
            if (this.value=="Edit") {

                //swap buttons
                rowButtonsToggle(row);
                disableEditCloneButtons(row.closest("table").attr("id"))
                oTable.columns.adjust().draw();

                //remove the action buttons         
                sectionWithQuestions.show();
                $('#action-btn-create').hide(); 
                //$('#action-btn-save').hide();
                $('.templateButton').hide(); 
                       
                
                //populate content fields per the data in the row
                for (var i = 0; i< columns.length - 1; i++){
                    K('field['+ columns[i].Name +']').value(oTable.row( row ).data()[i])
                }
            }

            if (this.value=="Clone") {

                //remove the action buttons         
                sectionWithQuestions.show();
                $('#action-btn-create').hide();
                $('#action-btn-save').show(); 
                $('.templateButton').hide();          
                
                //populate content fields per the data in the row
                for (var i = 1; i< questions.length; i++){
                    KD.utils.Action.setQuestionValue(questions[i],oTable.row( row ).data()[i]);
                }
            }
            
            if (this.value=="Cancel") {
                var verify = confirm('Are you sure you want to cancel edits to this Row');
                if (verify==true) {
                    //swap buttons
                    rowButtonsToggle(row);
                    enableEditCloneButtons(row.closest("table").attr("id"))
                    $('.templateButton').show(); 
                    oTable.columns.adjust().draw();

                    //$sectionWithQuestionsDiv.hide();
                    $('#action-btn-create').show(); 

                    //for (var i = 0; i< questions.length; i++){
                    //    KD.utils.Action.setQuestionValue(questions[i],"");
                    //}
                    
                }
            }
            
            if (this.value=="Delete") {
                var verify = confirm('Are you sure you want to delete this Row?');
                if (verify==true) {
                    jsonData.splice(rowIdentifier,1);
                    oTable.row(row).remove().draw();
                    KD.utils.Action.setQuestionValue(jsonQuestionName, JSON.stringify(jsonData));
                }
            }
            
            if (this.value=="Save") {               
                
                var newRow = [];
                // temp variable for building JSON object to be pushed to jsonData array
                var newRowJSON = {};               
                var allowSave = true;
                var serverName = KD.utils.Action.getQuestionValue(questions[0]);

                if(serverName != ""){
                    for (var i = 0; i < jsonData.length; i++){
                        if (jsonData[i]['Server Name'] == serverName) {
                            //allowSave = false;
                            //alert("Server Name must be unique. Please update values and try again.");
                        }
                    }
                }
                else{
                    allowSave = false;
                    bootbox.alert("Server Name can not be blank. Please update values and try again.");
                }
                if(allowSave){
                    // loop through each question and build up temp variables, also blank out questions 
                    for (var i = 0; i< columns.length; i++){
                        newRowJSON[columns[i].Name] = K('field['+ columns[i].Name +']').value();
                        newRow.push(K('field['+ columns[i].Name +']').value());
                        //KD.utils.Action.setQuestionValue(questions[i],"");
                    }
                    // push temp json object to jsonData array
                    jsonData[rowIdentifier]=newRowJSON;
                    // set the json question on the Service Item which ultimately saves the data
                    K('field['+ jsonQuestionName +']').value(JSON.stringify(jsonData))
                    // add the new row to the table
                    oTable.row(row).data(newRow).draw();

                    //$('#action-btn-save').hide();
                    //$sectionWithQuestionsDiv.hide();
                    $('#action-btn-create').show();
                    $('.templateButton').show();
                    enableEditCloneButtons(row.closest("table").attr("id"));
                    checkButtons();
                }
            }
        } );

    checkButtons();

    function checkButtons(){
        // Remove Delete Clone Buttons    
        if(allowDeleteClone == false){
                $(".btn-clone").hide();
                $(".btn-delete").hide();
            }
        }

        if ("ReviewRequest" != "ReviewRequest"){
            $(".btn-clone").hide();
            $(".btn-delete").hide();
            $(".btn-edit").hide();
        }
    }


    function rowButtonsToggle(row) {
        //make appropriate buttons visible on the identified row.  If editing, hide the edit and clone buttons.
        //if not editing, hide save and cancel.
        row.find($('.btn-edit')).toggle();
        row.find($('.btn-save')).toggle();
        row.find($('.btn-cancel')).toggle();
        row.find($('.btn-apply')).toggle();
        if(allowDeleteClone == true){
            row.find($('.btn-delete')).toggle();
            row.find($('.btn-clone')).toggle();
        }
    }

    function disableEditCloneButtons(tableID) {
        //disable all edit and clone buttons on the identified table once an edit is taking place
        $('#' + tableID + ' .btn-edit, #' + tableID + ' .btn-clone, #' + tableID + ' .btn-delete').attr("disabled", "disabled");
    };

    function enableEditCloneButtons(tableID) {
        //enable all edit and clone buttons on the identified table once an edit has been saved/applied or cancelled.
        if(allowDeleteClone == true){
            $('#' + tableID + ' .btn-edit, #' + tableID + ' .btn-clone, #' + tableID + ' .btn-delete').removeAttr("disabled");
        }
        else {
            $('#' + tableID + ' .btn-edit, #' + tableID).removeAttr("disabled");
        }

    };

    

    /*********************************************************/
    /*---------  End Add / Update Record Functions  ---------*/
    /*********************************************************/

}

