<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>




<!-- Modal -->
<div class="modal fade" id="lostTumblerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">분실 텀블러 알림</h5>
      </div>
      <div class="modal-body">
   		<div class="row">
   			<div class="col-12">
   				<div id="lost-message">
   					<p class="font-white">분실된 텀블러로 조회되었습니다.</p>
   					<p class="font-white">고객님에게 푸시 메세지를 송신합니다.</p>
   				</div>
   			</div>
   		</div>
   		<div class="row mt-3">
   			<div class="col-3 offset-9">
				<button id="sendLostMsg" type="button" class="btn btn-secondary float-right" data-dismiss="modal">보내기</button>	
			</div>
			<!-- <div class="col-3 offset-9">
				<button type="button" class="btn btn-secondary float-left" data-dismiss="modal">취소</button>	
			</div> -->
		</div>
      </div>
    </div>
  </div>
</div>
<script>
	$('#lostTumblerModal').on('shown.bs.modal', function(e){
		if(validateTumbler(tumblerInfo) != 0) {
			// 분실된 텀블러의 경우
			$("#lostTumblerModal").modal("hide");
			let msg = "분실된 텀블러가 아닙니다.";
			showAlert(msg, "lostTumblerModal", "alertModal");	
		}
	});
	
	$("#sendLostMsg").on("click", function(e){
		$.ajax({
            url: "/greenTumblerServer/fcm/sendLostMsg",
            type: "POST",
            data: {
                accountId: tumblerInfo.account_id,
                msg: tumblerInfo.nickName + " 님의 분실 텀블러가 남산스테이트점에서 조회되었습니다."
            },
            success: function(e) {
                console.log(e);
            }
        });
	})
</script>