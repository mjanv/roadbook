import Chart from 'chart.js/auto';

const chartOptions = {
  fill: true,
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      display: false,
    },
    tooltip: {
      enabled: false,
    },
  },
  layout: {
    padding: 0,
    autoPadding: false,
  },
  elements: {
    line: {
      tension: 0.3,
      borderCapStyle: 'round',
      borderJoinStyle: 'round',
      borderWidth: 0,
    },
    point: {
      radius: 5,
    },
  },
  scales: {
    x: {
      grid: {
        display: true,
        tickLength: 0,
      },
      ticks: {
        display: false,
      },
      border: {
        display: false,
      },
    },
    y: {
      grid: {
        display: true,
        tickLength: 0,
      },
      ticks: {
        display: false,
      },
      border: {
        display: false,
      },
    },
  },
};

const climbProfile = {
  points() {
    return this.el.dataset.points;
  },
  colors() {
    return this.el.dataset.colors;
  },
  mounted() {
    const points = JSON.parse(this.points());
    const colors = JSON.parse(this.colors());

    const ctx = this.el.getContext('2d');
    const chart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: [1, 2, 3, 4],
        datasets: [
          {
            backgroundColor: colors.background,
            borderColor: colors.border,
            borderWidth: 5,
            data: [{x: 1, y: 156}, {x: 2, y: 229}],
          },
          {
            backgroundColor: colors.background,
            borderColor: colors.border,
            borderWidth: 5,
            data: [{x: 2, y: 229}, {x: 3, y: 334}],
          },
          {
            backgroundColor: colors.background,
            borderColor: colors.border,
            borderWidth: 5,
            data: [{x: 3, y: 334}, {x: 4, y: 350}],
          }
        ],
      },
      options: chartOptions,
    });

    this.chart = chart;
  },
  updated() {
    this.destroyed();
    this.mounted();
  },
  destroyed() {
    this.chart.destroy();
  },
};

export default climbProfile;
