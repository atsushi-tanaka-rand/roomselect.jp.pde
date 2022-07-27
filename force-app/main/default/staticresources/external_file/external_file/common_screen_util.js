
    
    /**
     �y�[�W�J��
     �����ɑΉ��������@�Ńy�[�W�J�ڂ��s���܂��B
     @param pageName �J�ڐ�̃y�[�W��
     @param target �J�ڕ��@{'_self', '', '_blank'}
     @param hasHeader �w�b�_�[�����邩(TRUE������ȊO���Ŕ���){'TRUE', 'true'}
     @param param �p�����[�^
    **/
     function showPage(pageName, target, hasHeader, param) {
        // URL�Ƀp�����[�^��t�^
        // �p�����[�^��URL�����Ɂu�H�v��t���āA���̒���Ɂu�p�����[�^�����p�����[�^�l�v�Ƃ������`���Őݒ�
        // 2�ڈȍ~�̃p�����[�^�́u&�v�ŋ�؂��Đݒ�
        
        var url;
        
        var isApp;
        
        if(isApplication()){
            // �A�v���ł̏ꍇ
            isApp = 'true';
        }
        
        //���⍇��No0567�ŕύX
        // if(hasHeader.toLowerCase() != 'true' && !isApp){
        if(hasHeader.toLowerCase() != 'true' || isApp ){
            // hasHeader��true�ȊO�̏ꍇ���A�v���ł̏ꍇ
            //���⍇��No0567�ŕύX
            url =  '/apex/';
        } else {
            url =  '/one/one.app#/alohaRedirect/apex/';
        }
        
        var namespace = 'grung__';
        
        url += typeof(pageName) === 'undefined' || pageName === null || pageName.startsWith(namespace) ? pageName : namespace + pageName;
    
        // �p�����[�^��ݒ�
        url += '?' + param;
        
        var getTarget = target; // �y�[�W�̊J����(���y�[�W�A�V�K�^�u�A�V�K�E�B���h�E)
        var windowSet = ''; // ��ʑJ�ڕ��@���V�K�E�B���h�E�̏ꍇ�́A�I�v�V�����ݒ�
        
        // ��ʑJ�ڕ��@���V�K�E�B���h�E�̏ꍇ�ɁA�E�B���h�E�̍����ƕ���ݒ�
        if(getTarget == '_blank'){
            windowSet = 'width=5000,height=5000';
        }      
        
        // �A�v���ł��ǂ����𔻒�
        if(isApp){
            // ��ʑJ�� �A�v���ŗp
            sforce.one.navigateToURL(url);
        }else{
            // ��ʑJ��
            // window.open([url],[windowName],[option])
            // [windowName]�͐V�K�E�B���h�E('_blank'),�V�K�^�u(''),���y�[�W('_self')�Ɖ�ʑJ�ڕ��@��ݒ�
            // [option]�͐V�K�E�B���h�E���J�����ꍇ�̃E�B���h�E�̍����╝��ݒ�
            window.open(url, getTarget, windowSet);
        }
    }
    
    
    /**
    �y�[�W�����
    �y�[�W�J�ڂŊJ�����y�[�W����܂��B
    **/
    function closePage(){
        if(isApplication()){
            // �A�v���ŗp �߂�
            sforce.one.back(true);
        }else{
            //����
            window.open('','_top').close();
        }
    }   
    
    /**
    ��ʃX�N���[��
    �N���X�����w�肷�邱�ƂŁA�X�N���[�����܂�
    toClass�ɂ́A'.item_section'�̂悤�Ȍ`���ŃN���X���L�ڂ��܂��B
    **/
    function scrollToClass(toClass) {
    
        var n = window.location.href.slice(window.location.href.indexOf('?') + 4);
    
        var p = $(toClass).offset().top;
        $('html,body').animate({ scrollTop: p }, 'slow');
        return false;
    }
    
    /**
    �A�v���P�[�V��������
    �y�[�W���u���E�U����{�����Ă��邩�A�A�v���P�[�V�����ŉ{�����Ă��邩�𔻒肵�܂��B
    @return boolean �A�v���P�[�V�����̏ꍇtrue�A�A�v���P�[�V�����ꍇ�Ȃɂ��Ԃ��Ȃ�
    **/
    function isApplication(){                           
        
        //�u/�v�ŋ�؂��ĕ�������
        // ���[�U�̎g�p�u���E�U�����u/�v�ŋ�؂��ĕ�������
        var userAgent = window.navigator.userAgent.toLowerCase().split('/');
        
        // �A�v���P�[�V�����̏ꍇtrue��Ԃ�
        if(userAgent[0] == 'salesforcemobilesdk'){
            return true;
        }  
    }
    
    
    
    //���b�Z�[�W�p�F�y�[�W�ŏ㕔�Ɉړ�
    function gotoTop(){
        $(window).scrollTop(0);
    }
    
    
    //blockUI
    function blockUi() {
        $.blockUI({message: '<img src="/img/loading32.gif" /><h1> Loading...</h1>',
              css: {
                  border: 'none',
                  padding: '15px',
                  backgroundColor: '#FFF',
                  '-webkit-border-radius': '10px',
                  'border-radius': '10px',
                  opacity: 1,
                  color: '#000'
              }
         });
    }
        
        
    //UnblockUI
    function unblockUi() {
        $.unblockUI();
    }
    
    
    //�`�F�b�N�{�b�N�X�iapex:repeat���j�ύX���̒P��I������
    function onchangeListCheckBoxSingleSelect(CheckObject) {
        // Id�̍ŏI�K�w���擾
        var id = CheckObject.id.split(':');
        var searchId = id[id.length-1];
        // ���ꃊ�X�g���̓�Id�`�F�b�N�{�b�N�X�擾
        var td = $(CheckObject).parent();
        var tr = td.parent();
        var tbody = tr.parent();
        var checkList = tbody.find('input[id$="'+searchId+'"]');
        // �I��ύX�����`�F�b�N�{�b�N�X�ȊO�𖢑I���ɕύX
        for (var i=0; i < checkList.length; i++) {
            if (checkList[i].id!=CheckObject.id) {
                checkList[i].checked = false;
            }
        }
    }
    
    
    //�`�F�b�N�{�b�N�X �w�b�_�s�̃`�F�b�N�{�b�N�X�����삳�ꂽ�ۂ̏���
    function listCheckBoxAllChange(obj, headerCheckboxClass, childCheckboxClass){
        //�Ώۂ̒l���擾
        var flag = $(obj).prop('checked');
        //�e�v�f(table)�̔z���ɂ���`�F�b�N�{�b�N�X(.check)�̒l�𑀍�
        $(obj).closest('table').find(childCheckboxClass).prop('checked',flag);
    }
    
    
    //�`�F�b�N�{�b�N�X �`�F�b�N�{�b�N�X�̒l��false�ɕύX���ꂽ�ꍇ�ɁA�w�b�_�s�̃`�F�b�N�{�b�N�X�̒l�𑀍�
    function headCheckBoxChange(obj, headerCheckboxClass, childCheckboxClass){
        //�Ώۂ̒l���擾
        var flag = $(obj).prop('checked');
        
        //�w�b�_�̒l��ύX
        if (!flag) {
            $(headerCheckboxClass).prop('checked',false);
        } else {
        
            //�S��true�Ȃ�true�ɕύX
            var isAllTrue = true;
            $(childCheckboxClass).each(function(){
                var childValue = $(this).prop('checked');
                if (!childValue) {
                    isAllTrue = false;
                }
            });
            
            if (isAllTrue) {
                $(headerCheckboxClass).prop('checked',true);
            }
        }
    }
    
    
    //���͌��؃G���[�l�̃N���A
    function clearValidateErrorValue(input) {
        if (!input.checkValidity()) {
            input.value = '';
        }
        // ���t���͍��ڂ̃t�H�[�J�X���䒆�̏ꍇ�Afalse��ԋp���܂��B
        if (isDateInputKeydownFocusAdjust == true) {
            return false;
        }
        return true;
    }
    
    
    // �m�F�_�C�A���O��\��
    async function showConfirm(message) {
        var promise = new Promise(function(resolve, reject) {
            
            
            // Dialog��j������֐�
            var _destroyDialog = async function(dialogElement) {
                dialogElement.dialog('destroy'); // ��destroy�Ȃ̂ŁAclose�C�x���g�͔������Ȃ�
                dialogElement.remove(); // �����I�ɐ������ꂽ�v�f���폜����K�v������
            };
            
            // Dialog�v�f(�Ăяo�����ɁA���I�ɐ���)
            var $dialog = $('<div></div>').text(message);
            
            // �e�{�^���ɑΉ�����֐���錾
            // ��Dialog��j����A�R�[���o�b�N�֐������s����
            var _funcOk     = function() {
                _destroyDialog($dialog);
                resolve(true);
            };
            
            var _funcCancel = function() { 
                _destroyDialog($dialog);
                resolve(false);
            };
            
            // ���[�_�����̐ݒ�p�iiphone�p�j
            var clientWidth = 0; 
            if(document.body.clientWidth > 600){
                clientWidth = 600;
            }else{
                clientWidth = document.body.clientWidth;
            }
            
            //���I�Ƀ_�C�A���O�𐶐�
            $dialog.dialog({
                modal: true,
                title: '',
                width:  clientWidth,
                height: 200,
                
                // �u����v�̐ݒ�
                // ��Cancel���̏������u����v�Ɏd���ނ��ƂŁACancel�Ɓu����v�𓯈�̋����Ƃ���
                closeText: 'Cancel',
                closeOnEscape: true,
                close: _funcCancel,
                
                // �e�{�^���̐ݒ�
                buttons: [
                    { text: 'OK',     click: _funcOk },
                    { text: 'Cancel', click: function() { $(this).dialog('close'); } } // Dialog��close�̂�
                ]
            });
        });
        return promise;
    }
    
    //���⍇��No0549�Œǉ�
    /**
     �m�F�_�C�A���O��\��
     �~�{�^����Cancel�̃{�^�������Ńp�����[�^�𕪂���
     @param message �_�C�A���O�̕���
     @param OKButtonText OK�{�^���̕����i�������FOK�j
     @param cancelButtonText Cancel�{�^���̕����i�������FCancel�j
     @param param Integer 1:OK�A2:Cancel�A0:�~�ɂ�����
    **/
    async function showConfirmCloseMultiple(message,OKButtonText = 'OK',cancelButtonText = 'Cancel') {
        var promise = new Promise(function(resolve, reject) {
            
            // Dialog��j������֐�
            var _destroyDialog = async function(dialogElement) {
                dialogElement.dialog('destroy'); // ��destroy�Ȃ̂ŁAclose�C�x���g�͔������Ȃ�
                dialogElement.remove(); // �����I�ɐ������ꂽ�v�f���폜����K�v������
            };
            
            // Dialog�v�f(�Ăяo�����ɁA���I�ɐ���)
            var $dialog = $('<div></div>').text(message);
            // �_�C�A���O�����̖߂�l
            let buttonflg = 0;
            // �e�{�^���ɑΉ�����֐���錾
            // ��Dialog��j����A�R�[���o�b�N�֐������s����
            var _funcOk     = function() {
                buttonflg = 1;
                _destroyDialog($dialog);
                resolve(buttonflg);
            };
            
            var _funcCancel = function() { 
                _destroyDialog($dialog);
                resolve(buttonflg);
            };
            
            // ���[�_�����̐ݒ�p�iiphone�p�j
            var clientWidth = 0; 
            if(document.body.clientWidth > 600){
                clientWidth = 600;
            }else{
                clientWidth = document.body.clientWidth;
            }
            
            //���I�Ƀ_�C�A���O�𐶐�
            $dialog.dialog({
                modal: true,
                title: '',
                width:  clientWidth,
                height: 200,
                
                // �u����v�̐ݒ�
                // ��Cancel���̏������u����v�Ɏd���ނ��ƂŁACancel�Ɓu����v�𓯈�̋����Ƃ���
                closeText: 'Cancel',
                closeOnEscape: true,
                close: _funcCancel,
                
                // �e�{�^���̐ݒ�
                buttons: [
                    { text: OKButtonText,     click: _funcOk },
                    { text: cancelButtonText, click: function() { buttonflg = 2; $(this).dialog('close'); } } // Dialog��close�̂�
                ]
            });
        });
        return promise;
    }
    //���⍇��No0549�Œǉ�
    
    
    
    // �ʒm�_�C�A���O��\��
    async function showAlert(message) {
        var promise = new Promise(function(resolve, reject) {
            
            
            // Dialog��j������֐�
            var _destroyDialog = async function(dialogElement) {
                dialogElement.dialog('destroy'); // ��destroy�Ȃ̂ŁAclose�C�x���g�͔������Ȃ�
                dialogElement.remove(); // �����I�ɐ������ꂽ�v�f���폜����K�v������
            };
            
            // Dialog�v�f(�Ăяo�����ɁA���I�ɐ���)
            var $dialog = $('<div></div>').text(message);
            
            // �e�{�^���ɑΉ�����֐���錾
            // ��Dialog��j����A�R�[���o�b�N�֐������s����
            var _funcOk     = function() {
                _destroyDialog($dialog);
                resolve(true);
            };
            
            // ���[�_�����̐ݒ�p�iiphone�p�j
            var clientWidth = 0; 
            if(document.body.clientWidth > 600){
                clientWidth = 600;
            }else{
                clientWidth = document.body.clientWidth;
            }
            
            //���I�Ƀ_�C�A���O�𐶐�
            $dialog.dialog({
                modal: true,
                title: '',
                width:  clientWidth,
                height: 200,
                
                // �u����v�̐ݒ�
                // ��OK���̏������u����v�Ɏd����
                closeText: 'Cancel',
                closeOnEscape: true,
                close: _funcOk,   
                
                // �e�{�^���̐ݒ�
                buttons: [
                    { text: 'OK',     click: _funcOk },
                ]
            });
        });
        return promise;
    }
    
    // �ʒm�_�C�A���O��\���i�^�O���ߍ��݉j
    async function showAlert2(message) {
        let promise = new Promise(function(resolve, reject) {
            
            // Dialog��j������֐�
            let _destroyDialog = async function(dialogElement) {
                dialogElement.dialog('destroy'); // ��destroy�Ȃ̂ŁAclose�C�x���g�͔������Ȃ�
                dialogElement.remove(); // �����I�ɐ������ꂽ�v�f���폜����K�v������
            };
            
            // Dialog�v�f(�Ăяo�����ɁA���I�ɐ���)
            let $dialog = $('<div class="show-alert-height"></div>').html(message);
            
            // �e�{�^���ɑΉ�����֐���錾
            // ��Dialog��j����A�R�[���o�b�N�֐������s����
            let _funcOk     = function() {
                _destroyDialog($dialog);
                resolve(true);
            };
            
            // ���[�_�����̐ݒ�p�iiphone�p�j
            let clientWidth = 0; 
            if(document.body.clientWidth > 600){
                clientWidth = 600;
            }else{
                clientWidth = document.body.clientWidth;
            }
            
            //���I�Ƀ_�C�A���O�𐶐�
            $dialog.dialog({
                modal: true,
                title: '',
                width:  clientWidth,
                
                // �u����v�̐ݒ�
                // ��OK���̏������u����v�Ɏd����
                closeText: 'Cancel',
                closeOnEscape: true,
                close: _funcOk,   
                
                // �e�{�^���̐ݒ�
                buttons: [
                    { text: 'OK',     click: _funcOk },
                ]
            });
        });
        return promise;
    }
    
    var isDateInputKeydownFocusAdjust = false;  // ���t�t�H�[�J�X���䒆�t���O
    // ���t���͍��ڗp�t�H�[�J�X���䏈���ikeydown�����s�j
    function dateInputKeydownFocusAdjust(element, event) {
        
        // �S�p���͂��ꂽ�ꍇ�A�t�H�[�J�X�𑼍��ڂɈړ����Ȃ��悤�ɂ���B
        if (event.keyCode == 229) {
            
            // �_�~�[�v�f���i������΁j�쐬�����t���͍��ڂ̓��K�w�ɒǉ�
            var dmyExists = element.parentElement.querySelectorAll('[id="dateInputKeydownFocusAdjustDmy"]');
            var dmy;
            if (dmyExists.length == 0) {
                dmy = document.createElement('input');
                dmy.setAttribute('id', 'dateInputKeydownFocusAdjustDmy');
                dmy.setAttribute('type', 'text');
                dmy.setAttribute('style', 'opacity: 0; width: 0px; height: 0px; position: absolute; top: 0px; left: 0px');  // ����,���E����0,�e�v�f�̍���ɐ�Έʒu�w��z�u
                dmy.setAttribute('tabIndex', '-1');
                element.parentElement.appendChild(dmy);
                element.parentElement.classList.add('inputDateDummyParent');
            } else {
                dmy = dmyExists[0];
            }
            
            // �t�H�[�J�X���_�~�[�v�f�o�R�ł��Ē���
            isDateInputKeydownFocusAdjust = true;
            dmy.focus();
            setTimeout(() => element.focus(), 1);
            //dmy.parentNode.removeChild(dmy);
            isDateInputKeydownFocusAdjust = false;
            
        }
    }
    
    
    // �e�[�u����ړ������Q
    var dragTableId;        // �����e�[�u��
    var dragColIndex = -1;  // ������ԍ�
    // ��ړ�����
    function moveColmun(table, fromIndex, toIndex) {
        var rows = jQuery('tr', table);
        var cols;
        rows.each(function() {
            cols = jQuery(this).children('th, td');
            if (fromIndex > toIndex) {
                cols.eq(fromIndex).detach().insertBefore(cols.eq(toIndex));
            } else {
                cols.eq(fromIndex).detach().insertAfter(cols.eq(toIndex));
            }
            
        });
    }
    // ��ړ������̌ďo���C�x���g�ݒ�
    function setDraggableTable(tableId) {
        var draggableTable = document.getElementById(tableId);
        // �h���b�O�J�n�����쐬
        var colDragStart = function(e) {
            var el = e.target;
            if (el.tagName != 'TH') {
                return;
            }
            // �h���b�O��̔ԍ���ޔ�
            dragTableId = draggableTable.id;
            dragColIndex = el.cellIndex;
        }
        // �h���b�O�������쐬
        var colDragover = function(e) {
            // �h���b�v�\�ݒ�
            e.preventDefault();
        }
        // �h���b�v�������쐬
        var colDragEnd = function(e) {
            var el = this;
            if (el.tagName != 'TH') {
                return;
            }
            // �h���b�O�ƃh���b�v���e�[�u���̏ꍇ�A�������~
            if (dragTableId != getTableFromTh(e.currentTarget).id) {
                return;
            }
            // �h���b�v��̔ԍ��擾
            var dragToIndex = el.cellIndex;
            // �h���b�O�ƃh���b�v�������A��ԍ����s���̏ꍇ�A�������~
            if (dragColIndex == dragToIndex || dragColIndex < 0 || dragToIndex < 0) {
                return;
            }
            // �h���b�O����h���b�v��̑O�Ɉړ�
            moveColmun(draggableTable, dragColIndex, dragToIndex);
        }
        // �ȉ���w�b�_�ݒ�
        var cols = $(draggableTable).find('th');
        // id�ݒ�
        var i=0;
        cols.each(function() {
            this.id = draggableTable.id + 'TH' + (i + 1);
            i++;
        });
        $(cols).prop('draggable', true);
        // �h���b�O�\��
        $(cols).prop('draggable', true);
        // �e�C�x���g��R�Â�
        cols.on('dragstart', colDragStart);
        cols.on('dragover', colDragover);
        cols.on('drop', colDragEnd);
    }
    // th�w���table�v�f�擾
    function getTableFromTh(el) {
        var temp = el.parentElement;
        for (var i=0; i<10; i++) {
            if (temp.tagName == 'TABLE') {
                return temp;
            }
            temp = temp.parentElement;
        }
        return null;
    }
    
    
    // �e�[�u���\�[�g�����Q
    var sortOrderImageSrc;
    // �\�[�g�����̌ďo���C�x���g�ݒ�
    function setSortableTable(tableId, defaultSortOrder) {
    
        // �Ώۃe�[�u���擾
        var sortableTable = document.getElementById(tableId);
    
        // �f�t�H���g�\�[�g�`���擾�i�w�肪�Ȃ���Ώ����Ƃ���j
        defaultSortOrder = [null, ''].includes(defaultSortOrder) ? '1' : defaultSortOrder;
        defaultSortOrder = ['1', '-1'].includes(defaultSortOrder) ? defaultSortOrder : '1';
    
        // �A���\�[�g�e�[�u��Id�擾
        var linkTableIds = '';
        if (sortableTable.hasAttribute('data-sortLinkTableIds')) {
            linkTableIds = sortableTable.getAttribute('data-sortLinkTableIds');
        }
    
        // �N���b�N�����쐬
        var colClick = function(e) {
            //blockUi();
            // �\�[�g��̔ԍ��擾
            var sortColIndex = this.cellIndex;
            // �\�[�g�`���i����/�~���j�̎擾
            var sortOrder = Number(this.getAttribute('data-sortOrder'));
            // �\�[�g�^�̎擾�i�w�肪�Ȃ��ꍇ�A������j
            var sortType = this.getAttribute('data-sortType');
            sortType = [null, ''].includes(sortType) ? 'string' : sortType.toLowerCase();
            // �\�[�g���s
            sortRows(this, sortableTable, sortColIndex, sortOrder, sortType);
            // �\�[�g�`���̐ؑցi����<=>�~���j
            this.setAttribute('data-sortOrder', sortOrder * -1);
            //unblockUi();
        }
    
        // �e�s��tr�v�f�ɏ����sindex�ݒ� ���w�b�_�s�i1�s�ځj������
        var rows = $(sortableTable).find('tr');
        rows = rows.slice(1, rows.length);
        rows.each(function(index) {
            this.setAttribute('data-initRowIndex', index);
        });
    
        // �A���e�[�u�����擾
        var linkTableIdList = [null, ''].includes(linkTableIds) ? [] : linkTableIds.split(',');
        // �A���e�[�u���ɏ����sindex��ݒ� ���w�b�_�s�i1�s�ځj������
        $(linkTableIdList).each(function() {
            // �A���e�[�u���擾
            var linkSortTable = document.getElementById(this.trim());
            var linkRows = $(linkSortTable).find('tr');
            linkRows = linkRows.slice(1, linkRows.length);
            linkRows.each(function(index) {
                this.setAttribute('data-initRowIndex', index);
            });
        });
    
        // �ȉ���w�b�_�ݒ�
        var cols = $(sortableTable).find('th');
        cols.each(function() {
            // �\�[�g�`���i����/�~���j�̐ݒ�
            //  �w��Ȃ���1,-1�ȊO���f�t�H���g�l�Ƃ���
            if (!this.hasAttribute('data-sortOrder') || !['1', '-1'].includes(this.getAttribute('data-sortOrder'))) {
                this.setAttribute('data-sortOrder', defaultSortOrder);
            }
            // �\�[�g�`���̏�����Ԃ�ێ����Ă���
            this.setAttribute('data-initSortOrder', this.getAttribute('data-sortOrder'));
            // �N���b�N�C�x���g��R�Â��i�\�[�g���Ȃ��ݒ肳�ꂽ��͏����j
            var colSotable = this.getAttribute('data-colSortable');
            colSotable = [null, ''].includes(colSotable) ? '' : colSotable.toLowerCase();
            if (colSotable != 'false') {
                $(this).on('click', colClick);
            }
            // �\�[�g��ԉ摜������ class�usortOrderImage�v���ݒ肳�ꂽ��̂�
            var sortOrderImg = $(this).find('.sortOrderImage');
            if (sortOrderImg.length > 0) {
                if (!this.hasAttribute('data-initSortOrderImageKey') || !['1', '0', '-1'].includes(this.getAttribute('data-initSortOrderImageKey'))) {
                    $(sortOrderImg).prop('src', sortOrderImageSrc.get(0));
                } else {
                    // �����l�̎w�肪����Ă���ꍇ���̉摜��\������
                    $(sortOrderImg).prop('src', sortOrderImageSrc.get(Number(this.getAttribute('data-initSortOrderImageKey'))));
                }
            }
        });
    
        // �����\�[�g���s���i�w�肪����ꍇ�j
        cols.each(function() {
            if (this.hasAttribute('data-initSort') || ['1', '-1'].includes(this.getAttribute('data-initSort'))) {
                // �\�[�g��̔ԍ��擾
                var sortColIndex = this.cellIndex;
                // �\�[�g�`���i����/�~���j�̎擾
                var sortOrder = Number(this.getAttribute('data-initSort'));
                // �\�[�g�^�̎擾�i�w�肪�Ȃ��ꍇ�A������j
                var sortType = this.getAttribute('data-sortType');
                sortType = [null, ''].includes(sortType) ? 'string' : sortType.toLowerCase();
                // �\�[�g���s
                sortRows(this, sortableTable, sortColIndex, sortOrder, sortType);
                // �\�[�g�`���̐ؑցi����<=>�~���j
                this.setAttribute('data-sortOrder', sortOrder * -1);
            }
        });
    
    }
    // �\�[�g����
    function sortRows(th, sortTable, sortColIndex, sortOrder, sortType, tableId) {
        // �e�[�u���S�s�擾 ���w�b�_�s�i1�s�ځj������
        var rows = $(sortTable).find('tr');
        rows = rows.slice(1, rows.length);
    
        // �\�[�g���s
        sortType = [null, ''].includes(sortType) ? '' : sortType.toLowerCase();
        rows.sort(function(a, b) {
            return sortCompare(a, b, sortColIndex, sortType, sortOrder);
        });
    
        // ���ѕς����s��z�u������
        var body = $(sortTable).children('tbody');
        if (body.length >= 2) {
            $(sortTable).children('tbody').eq(body.length-1).append(rows.detach());
        } else {
            $(sortTable).children('tbody').append(rows.detach());
        }
    
        // �A���e�[�u�����擾
        var linkTableIds = sortTable.getAttribute('data-sortLinkTableIds');
        var linkTableIdList = [null, ''].includes(linkTableIds) ? [] : linkTableIds.split(',');
    
        // �A���e�[�u���ݒ肪����Ă���ꍇ�A�s�\�[�g���𓯊�������
        if (linkTableIdList.length > 0) {
            // �\�[�g��̏����sindex��z��
            var sortIndexSet = [];
            rows.each(function(index) {
                sortIndexSet.push(Number(this.getAttribute('data-initRowIndex')));
            });
    
            // �A���e�[�u���Ƀ\�[�g��������
            $(linkTableIdList).each(function() {
                // �A���e�[�u���擾
                var linkSortTable = document.getElementById(this.trim());
                // �s�\�[�g
                linkSortFromIndex(linkSortTable, sortIndexSet);
            });
        }
    
        var cols = $(sortTable).find('th');
        var rowNumberColIndexs = [];
        var resettingRowNumberColIndexs = [];
        $(cols).each(function() {
            // �\�[�g�`���̏�����
            this.setAttribute('data-sortOrder', this.getAttribute('data-initSortOrder'));
            // �s�ԍ��̗�擾
            if (this.hasAttribute('data-rowNumberCol')) {
                rowNumberColIndexs.push(this.cellIndex);
            }
            // �s�ԍ����ڍăZ�b�g��擾
            if (this.hasAttribute('data-resettingRowNumberCol')) {
                resettingRowNumberColIndexs.push(this.cellIndex);
            }
        });
        // �s�ԍ���̓��e�ݒ�
        if (rowNumberColIndexs.length > 0) {
            rows.each(function(index) {
                for (var i=0; i < rowNumberColIndexs.length; i++) {
                    $(this).find('td').eq(rowNumberColIndexs[i]).prop('innerText', String(index + 1));
                }
            });
        }
        // �s�ԍ����ڂւ̓��e�ݒ�
        if (resettingRowNumberColIndexs.length > 0) {
            rows.each(function(index) {
                for (var i=0; i < resettingRowNumberColIndexs.length; i++) {
                    $(this).find('td').eq(resettingRowNumberColIndexs[i]).find('[id$=resettingRowNumber]').prop('value', String(index + 1));
                }
            });
        }
    
        // �\�[�g��ԉ摜�̕ύX class�usortOrderImage�v���ݒ肳�ꂽ��̂�
        var sortOrderImg = $(sortTable).find('.sortOrderImage');
        if (sortOrderImg.length > 0) {
            // ������
            $(sortOrderImg).prop('src', sortOrderImageSrc.get(0));
        }
        sortOrderImg = $(th).find('.sortOrderImage');
        if (sortOrderImg.length > 0) {
            // ����Ԃ̐ݒ�
            $(sortOrderImg).prop('src', sortOrderImageSrc.get(sortOrder));
        }
        // �A���e�[�u���̃\�[�g��ԉ摜������
        if (linkTableIdList.length > 0) {
            $(linkTableIdList).each(function() {
                // �A���e�[�u���擾
                var linkSortTable = document.getElementById(this.trim());
                // �\�[�g�`��������
                cols = $(linkSortTable).find('th');
                rowNumberColIndexs = [];
                resettingRowNumberColIndexs = [];
                $(cols).each(function() {
                    this.setAttribute('data-sortOrder', this.getAttribute('data-initSortOrder'));
                    // �s�ԍ��̗�擾
                    if (this.hasAttribute('data-rowNumberCol')) {
                        rowNumberColIndexs.push(this.cellIndex);
                    }
                    // �s�ԍ����ڍăZ�b�g��擾
                    if (this.hasAttribute('data-resettingRowNumberCol')) {
                        resettingRowNumberColIndexs.push(this.cellIndex);
                    }
                });
                // �s�ԍ���̓��e�ݒ�
                var linkRows = $(linkSortTable).find('tr');
                linkRows = linkRows.slice(1, rows.length);
                if (rowNumberColIndexs.length > 0) {
                    linkRows.each(function(index) {
                        for (var i=0; i < rowNumberColIndexs.length; i++) {
                            $(this).find('td').eq(rowNumberColIndexs[i]).prop('innerText', String(index + 1))
                        }
                    });
                }
                // �s�ԍ����ڂւ̓��e�ݒ�
                if (resettingRowNumberColIndexs.length > 0) {
                    rows.each(function(index) {
                        for (var i=0; i < resettingRowNumberColIndexs.length; i++) {
                            $(this).find('td').eq(resettingRowNumberColIndexs[i]).find('[id$=resettingRowNumber]').prop('value', String(index + 1));
                        }
                    });
                }
                // �\�[�g��ԉ摜������
                sortOrderImg = $(linkSortTable).find('.sortOrderImage');
                if (sortOrderImg.length > 0) {
                    // ����Ԃ̐ݒ�
                    $(sortOrderImg).prop('src', sortOrderImageSrc.get(0));
                }
            });
        }
    }
    // �\�[�g���̔�r����
    function sortCompare(a, b, colIndex, sortType, sortOrder) {
        // ��r�s�̑Ώۗ�f�[�^�擾
        var _a = $(a).find('td').eq(colIndex).text();
        var _b = $(b).find('td').eq(colIndex).text();
        // ���l�^�̔�r
        if (sortType == 'number') {
            if (isNumber(_a) && isNumber(_b)) {
                return (_a - _b) * sortOrder;
            }
            if (isNumber(_a)) {
                return 1 * sortOrder;
            }
            if (isNumber(_b)) {
                return -1 * sortOrder;
            }
        }
        // �t�H�[�}�b�g���|���������l�^�̔�r
        if (sortType == 'format-number') {
            // ���l�Ɓu.�v�u-�v�ȊO����菜���Ĕ�r����
            var __a = ['', null].includes(_a) ? '' : _a.replace(/[^0-9.-]/g,'');
            var __b = ['', null].includes(_b) ? '' : _b.replace(/[^0-9.-]/g,'');
            if (isNumber(__a) && isNumber(__b)) {
                return (__a - __b) * sortOrder;
            }
            if (isNumber(__a)) {
                return 1 * sortOrder;
            }
            if (isNumber(__b)) {
                return -1 * sortOrder;
            }
        }
        // �ʏ��r�i������j
        if (_a > _b) {
            return 1 * sortOrder;
        }
        if (_a < _b) {
            return -1 * sortOrder;
        }
    }
    // ���l����
    function isNumber(value) {
        if (!isFinite(value) || value == '' || value == null || typeof value == 'boolean') {
            return false;
        }
        return true;
    }
    // �A���\�[�g�e�[�u���ւ̃\�[�g���f����
    function linkSortFromIndex(linkSortTable, sortIndexSet) {
        // �A���e�[�u���S�s�擾
        var linkRows = $(linkSortTable).find('tr');
        linkRows = linkRows.slice(1, linkRows.length);
    
        // ����index���L�[�Ƃ�����index�̘A�z�z����쐬
        var linkSortIndexSet = {};
        linkRows.each(function(index) {
            linkSortIndexSet[String(this.getAttribute('data-initRowIndex'))] = index;
        });
    
        // �\�[�g�㏇�̏���index���L�[�ɘA���\�[�g
        var linkSortRows = [];
        $(sortIndexSet).each(function() {
            linkSortRows.push(linkRows[linkSortIndexSet[String(this)]]);
        });
    
        // ���ѕς����s��z�u������
        var body = $(linkSortTable).children('tbody');
        if (body.length >= 2) {
            $(linkSortTable).children('tbody').eq(body.length-1).append($(linkSortRows).detach());
        } else {
            $(linkSortTable).children('tbody').append($(linkSortRows).detach());
        }
    
    }
    
    
    // ���X�N���[���A��
    function linkScrollX(orgElement, targetElementId) {
        var target = document.getElementById(targetElementId);
        target.scrollLeft = orgElement.scrollLeft;
    }
    // �c�X�N���[���A��
    var linkScrollYProcessing = 0;
    function linkScrollY(orgElement, targetElementId) {
        if (linkScrollYProcessing == 0) {
            linkScrollYProcessing = 1;
            var target = document.getElementById(targetElementId);
            target.scrollTop = orgElement.scrollTop;
            setTimeout(function() {
                target.scrollTop = orgElement.scrollTop;
                setTimeout(function() {
                    linkScrollYProcessing = 0;
                }, 15);
            }, 20);
        }
    }
    
    
    // �e�[�u���w�b�_�A�{�f�B�̕���������
    function tableColResize(tableId, isExcludeLastCol) {
    
        // �ŏI�s�ΏۊO�t���O
        if (isExcludeLastCol == null) {
            isExcludeLastCol = false;
        }
    
        // �Ώۃe�[�u���擾
        var targetTable = document.getElementById(tableId);
    
        // �e�[�u���̑S�s�擾
        var rows = jQuery('tr', targetTable);
    
        // �f�[�^0�s�̏ꍇ�����I��
        if (rows.length < 2) { return; }
    
        // �w�b�_�s�̗�擾
        var headerCols = rows.eq(0).find('th');
    
        // 1�f�[�^�ڂ̗�擾
        var bodyCols = rows.eq(1).find('td');
    
        // �񕝒���
        headerCols.each(function(index) {
            if (isExcludeLastCol) {
                if (headerCols.length == index + 1) {
                    return false;
                }
            }
            var headerWidth = $(headerCols[index]).outerWidth();
            var bodyWidth   = $(bodyCols[index]).outerWidth();
            if (headerWidth < bodyWidth) {
                // �w�b�_���f�[�^�̏ꍇ�A�e��̕����f�[�^�ɍ��킹��
                rows.each(function() {
                    var data = $($(this).children('th, td')).eq(index);
                    $(data).css('min-width', bodyWidth + 'px');
                });
            } else if (headerWidth > bodyWidth) {
                // �w�b�_���f�[�^�̏ꍇ�A�e��̕����w�b�_�ɍ��킹��
                rows.each(function() {
                    var data = $($(this).children('th, td')).eq(index);
                    $(data).css('min-width', headerWidth + 'px');
                });
            }
        });
    }
    
    /**
     * �g�p�u���E�U��Safari�ł��邩�̔���
     * @return true:safari false:����ȊO
     */
    function isUseBrowserSafari() {
      return (useBrowser() == 'safari');
    }
    
    /**
    �g�p�u���E�U���菈��
    �g�p���Ă���u���E�U�𕶎���i�������j�ɂĕԋp
    @return �u���E�U��
    **/
    function useBrowser() {
      var userAgent = window.navigator.userAgent.toLowerCase();
      var useBrowser = '';
      if(userAgent.indexOf('msie') != -1) {
          useBrowser = 'msie';
      } else if(userAgent.indexOf('trident') != -1) {
          useBrowser = 'trident';
      } else if(userAgent.indexOf('edge') != -1) {
          useBrowser = 'edge';
      } else if(userAgent.indexOf('chrome') != -1) {
          useBrowser = 'chrome';
      } else if(userAgent.indexOf('safari') != -1) {
          useBrowser = 'safari';
      } else if(userAgent.indexOf('firefox') != -1) {
          useBrowser = 'firefox';
      } else if(userAgent.indexOf('opera') != -1) {
          useBrowser = 'opera';
      }
      return useBrowser;
    }
    