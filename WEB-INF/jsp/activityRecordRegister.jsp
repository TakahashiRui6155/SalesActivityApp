<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>営業成績登録</title>
</head>

<body>

	<h1>営業成績登録</h1>

	<form action="${pageContext.request.contextPath}/activity-record-register"
		  method="post">

		<div>
			<label for="memberId">会員ID</label>
			<input type="number" id="memberId" name="memberId" required>
		</div>

		<div>
			<label for="recordDate">記録日</label>
			<input type="date" id="recordDate" name="recordDate" required>
		</div>

		<div>
			<label for="periodStart">集計期間開始日</label>
			<input type="date" id="periodStart" name="periodStart" required>
		</div>

		<div>
			<label for="periodEnd">集計期間終了日</label>
			<input type="date" id="periodEnd" name="periodEnd" required>
		</div>

		<div>
			<label for="activityCount">活動件数</label>
			<input type="number" id="activityCount"
				   name="activityCount" min="0" required>
		</div>

		<div>
			<label for="activityGoal">活動目標</label>
			<input type="number" id="activityGoal"
				   name="activityGoal" min="0" required>
		</div>

		<div>
			<label for="visitConversationCount">訪問商談件数</label>
			<input type="number" id="visitConversationCount"
				   name="visitConversationCount" min="0" required>
		</div>

		<div>
			<label for="phoneConversationCount">電話商談件数</label>
			<input type="number" id="phoneConversationCount"
				   name="phoneConversationCount" min="0" required>
		</div>

		<div>
			<label for="emailResponseCount">メール返信件数</label>
			<input type="number" id="emailResponseCount"
				   name="emailResponseCount" min="0" required>
		</div>

		<div>
			<label for="apCount">アポイント件数</label>
			<input type="number" id="apCount"
				   name="apCount" min="0" required>
		</div>

		<div>
			<label for="apGoal">アポイント目標</label>
			<input type="number" id="apGoal"
				   name="apGoal" min="0" required>
		</div>

		<div>
			<button type="submit">登録</button>
		</div>

	</form>

</body>
</html>