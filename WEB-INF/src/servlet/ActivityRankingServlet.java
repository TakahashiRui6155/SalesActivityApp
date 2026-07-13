package servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ActivityRecordDAO;
import model.ActivityRanking;

@WebServlet("/activity-ranking")
public class ActivityRankingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ActivityRankingServlet() {
        super();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType(
                "text/html; charset=UTF-8");

        String startDateParameter =
                request.getParameter("startDate");

        String endDateParameter =
                request.getParameter("endDate");
        
        String rankingType =
                request.getParameter("rankingType");

        if (rankingType == null
                || rankingType.isEmpty()) {

            rankingType = "appointments";
        }

        LocalDate today = LocalDate.now();

        /*
         * 日付が入力されていない場合は、
         * 今月1日から今日までを初期値にする
         */
        LocalDate startLocalDate;
        LocalDate endLocalDate;

        try {

            if (startDateParameter == null
                    || startDateParameter.isEmpty()) {

                startLocalDate =
                        today.withDayOfMonth(1);

            } else {

                startLocalDate =
                        LocalDate.parse(
                                startDateParameter);
            }

            if (endDateParameter == null
                    || endDateParameter.isEmpty()) {

                endLocalDate = today;

            } else {

                endLocalDate =
                        LocalDate.parse(
                                endDateParameter);
            }

            /*
             * 開始日が終了日より後になっていないか確認
             */
            if (startLocalDate.isAfter(endLocalDate)) {

                request.setAttribute(
                        "errorMessage",
                        "開始日は終了日以前の日付を指定してください。");

                request.setAttribute(
                        "startDate",
                        startLocalDate.toString());

                request.setAttribute(
                        "endDate",
                        endLocalDate.toString());

                request.getRequestDispatcher(
                        "/WEB-INF/jsp/activityRanking.jsp")
                        .forward(request, response);

                return;
            }

            Date startDate =
                    Date.valueOf(startLocalDate);

            Date endDate =
                    Date.valueOf(endLocalDate);

            ActivityRecordDAO activityRecordDAO =
                    new ActivityRecordDAO();

            List<ActivityRanking> rankingList =
                    activityRecordDAO.findRanking(
                            startDate,
                            endDate,
                            rankingType);

            request.setAttribute(
                    "rankingList",
                    rankingList);
            
            request.setAttribute(
                    "rankingType",
                    rankingType);

            request.setAttribute(
                    "startDate",
                    startLocalDate.toString());

            request.setAttribute(
                    "endDate",
                    endLocalDate.toString());

            request.getRequestDispatcher(
                    "/WEB-INF/jsp/activityRanking.jsp")
                    .forward(request, response);

        } catch (IllegalArgumentException e) {

            request.setAttribute(
                    "errorMessage",
                    "正しい日付を入力してください。");

            request.getRequestDispatcher(
                    "/WEB-INF/jsp/activityRanking.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "ランキングの取得中にエラーが発生しました。");

            request.getRequestDispatcher(
                    "/WEB-INF/jsp/activityRanking.jsp")
                    .forward(request, response);
        }
    }
}
