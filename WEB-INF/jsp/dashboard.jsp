<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ダッシュボード</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body {
    margin: 0;
    font-family: Arial, "メイリオ", sans-serif;
    background-color: #f4f6f9;
    color: #333333;
}

.container {
    width: 90%;
    max-width: 1100px;
    margin: 40px auto;
}

h1 {
    margin-top: 0;
    margin-bottom: 30px;
}

h2 {
    margin-top: 30px;
    margin-bottom: 20px;
}

/* サマリー表示 */
.summary-area {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    margin-bottom: 40px;
}

.summary-card {
    padding: 25px;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.summary-card h3 {
    margin-top: 0;
    margin-bottom: 15px;
    font-size: 16px;
    color: #666666;
}

.summary-card p {
    margin: 0;
    font-size: 28px;
    font-weight: bold;
    color: #222222;
}

/* グラフ表示 */
.chart-section {
    width: 90%;
    max-width: 1000px;
    margin: 0 auto 40px;
}

.chart-section h2 {
    margin-top: 0;
}

.chart-card {
    width: 100%;
    height: 260px;
    padding: 20px;
    box-sizing: border-box;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.chart-card canvas {
    width: 100% !important;
    height: 100% !important;
}

/* メニュー表示 */
.menu-section {
    width: 90%;
    max-width: 900px;
    margin: 0 auto 40px;
}

.menu-section h2 {
    margin-top: 0;
    margin-bottom: 16px;
}

.menu-area {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 14px;
}

.menu-button {
    display: flex;
    justify-content: center;
    align-items: center;

    min-height: 48px;
    padding: 8px 15px;

    background-color: #007bff;
    color: #ffffff;

    text-decoration: none;
    font-size: 15px;
    font-weight: bold;

    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);

    transition:
        background-color 0.2s,
        transform 0.2s;
}

.menu-button:hover {
    background-color: #0056b3;
    transform: translateY(-2px);
}

/* タブレット表示 */
@media screen and (max-width: 800px) {
    .summary-area {
        grid-template-columns: repeat(2, 1fr);
    }

    .chart-section,
    .menu-section {
        width: 100%;
    }
}

/* スマートフォン表示 */
@media screen and (max-width: 500px) {
    .container {
        width: 92%;
        margin: 20px auto;
    }

    .summary-area,
    .menu-area {
        grid-template-columns: 1fr;
    }

    .summary-card p {
        font-size: 24px;
    }

    .chart-card {
        height: 300px;
        padding: 12px;
    }
}
</style>

</head>

<body>

<div class="container">

    <h1>フリー名簿活動管理ダッシュボード</h1>

    <h2>営業成績サマリー</h2>

    <div class="summary-area">

        <div class="summary-card">
            <h3>活動件数合計</h3>
            <p>${totalActivityCount} 件</p>
        </div>

        <div class="summary-card">
            <h3>活動目標合計</h3>
            <p>${totalActivityGoal} 件</p>
        </div>

        <div class="summary-card">
            <h3>アポ件数合計</h3>
            <p>${totalApCount} 件</p>
        </div>

        <div class="summary-card">
            <h3>アポ率</h3>
            <p>${appointmentRate} %</p>
        </div>

    </div>

    <div class="chart-section">

        <h2>実績・目標比較</h2>

        <div class="chart-card">
            <canvas id="performanceChart"></canvas>
        </div>

    </div>

    <div class="menu-section">

        <h2>メニュー</h2>

        <div class="menu-area">

            <a class="menu-button"
                href="${pageContext.request.contextPath}/activity-record">
                営業成績登録
            </a>

            <a class="menu-button"
                href="${pageContext.request.contextPath}/activity-record-list">
                営業成績一覧
            </a>

            <a class="menu-button"
                href="${pageContext.request.contextPath}/activity-ranking">
                ランキング
            </a>

            <a class="menu-button"
                href="${pageContext.request.contextPath}/memberList">
                会員一覧
            </a>

        </div>

    </div>

</div>

<script>
const chartCanvas = document.getElementById("performanceChart");

const performanceChart = new Chart(chartCanvas, {
    type: "bar",

    data: {
        labels: ["活動件数", "アポ件数"],

        datasets: [
            {
                label: "活動実績",
                data: [
                    ${totalActivityCount},
                    null
                ],
                backgroundColor: "rgba(54, 162, 235, 0.75)",
                borderColor: "rgba(54, 162, 235, 1)",
                borderWidth: 1,
                yAxisID: "activityAxis"
            },
            {
                label: "活動目標",
                data: [
                    ${totalActivityGoal},
                    null
                ],
                backgroundColor: "rgba(255, 159, 64, 0.75)",
                borderColor: "rgba(255, 159, 64, 1)",
                borderWidth: 1,
                yAxisID: "activityAxis"
            },
            {
                label: "アポ実績",
                data: [
                    null,
                    ${totalApCount}
                ],
                backgroundColor: "rgba(75, 192, 192, 0.75)",
                borderColor: "rgba(75, 192, 192, 1)",
                borderWidth: 1,
                yAxisID: "appointmentAxis"
            },
            {
                label: "アポ目標",
                data: [
                    null,
                    ${totalApGoal}
                ],
                backgroundColor: "rgba(153, 102, 255, 0.75)",
                borderColor: "rgba(153, 102, 255, 1)",
                borderWidth: 1,
                yAxisID: "appointmentAxis"
            }
        ]
    },

    options: {
        responsive: true,
        maintainAspectRatio: false,

        plugins: {
            legend: {
                position: "top",
                labels: {
                    font: {
                        size: 13,
                        weight: "bold"
                    }
                }
            }
        },

        scales: {
            x: {
                ticks: {
                    font: {
                        weight: "bold"
                    }
                }
            },

            activityAxis: {
                type: "linear",
                position: "left",
                beginAtZero: true,

                title: {
                    display: true,
                    text: "活動件数",
                    font: {
                        size: 14,
                        weight: "bold"
                    }
                },

                ticks: {
                    precision: 0,
                    font: {
                        weight: "bold"
                    }
                }
            },

            appointmentAxis: {
                type: "linear",
                position: "right",
                beginAtZero: true,
                suggestedMax: 10,

                title: {
                    display: true,
                    text: "アポ件数",
                    font: {
                        size: 14,
                        weight: "bold"
                    }
                },

                ticks: {
                    precision: 0,
                    stepSize: 1,
                    font: {
                        weight: "bold"
                    }
                },

                grid: {
                    drawOnChartArea: false
                }
            }
        }
    }
});
</script>

</body>
</html>