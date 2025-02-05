let selectedSeats = [];

function toggleSeat(seatId) {
    const seatButton = document.getElementById(`seat-${seatId}`);
    if (seatButton.classList.contains("unavailable")) {
        return;
    }
    seatButton.classList.toggle("selected");
    if (seatButton.classList.contains("selected")) {
        selectedSeats.push(seatId);
    } else {
        selectedSeats = selectedSeats.filter(seat => seat !== seatId);
    }
    document.getElementById("selected-seats").value = selectedSeats.join(",");
}
