const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.json());

// FPX Payment API endpoint
app.post('/fpx/payment', async (req, res) => {
  try {
    // Extract payment details from request
    const { bankAccountNumber, amount } = req.body;

    // Perform necessary validation and formatting of payment details

    // Call FPX payment gateway API (replace with actual API endpoint)
    const paymentResponse = await axios.post('https://fpx-payment-gateway.com/process', {
      bankAccountNumber,
      amount,
      // Include any additional required parameters
    });

    // Process payment response from FPX gateway
    const paymentStatus = paymentResponse.data.status;

    // Respond to Flutter app with payment status
    res.json({ status: paymentStatus });
  } catch (error) {
    console.error('Error processing payment:', error);
    res.status(500).json({ error: 'Failed to process payment' });
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
