# Lens Protocol Authentication Flows

This document outlines the steps for logging into an existing Lens account and creating a new one.

## Login to Lens Flow

1.  **Connect Wallet:** Obtain the user's wallet address (e.g., `0x123...`).
2.  **Check Account Availability:** Call `AccountAvailable` with the wallet address to verify if a Lens account is associated with it.
    *   **Input:** Wallet Address (Account Owner)
3.  **Handle Account Status:**
    *   **If No Account Exists:** Proceed to the [Create Lens Account Flow](#create-lens-account-flow).
    *   **If Account Exists:** Call `LensChallenge` to get a message to sign.
        *   **Request Payload:**
            ```json
            {
              "account": "<USER_WALLET_ADDRESS>",
              <!-- Might not need -->
              "app": "0xaC19aa2402b3AC3f9Fe471D4783EC68595432465", // Lens app ID
              "owner": "<SIGNER_ADDRESS>"
            }
            ```
4.  **Sign Message:** Have the user sign the challenge message received from `LensChallenge` using their connected wallet.
5.  **Authenticate:** Call `LensAuthenticate` with the signed message to receive authentication tokens (access token, refresh token, id token).

## Create Lens Account Flow

This flow is initiated if the user does not have an existing Lens account linked to their connected wallet.

1.  **Get Onboarding Challenge:** Call `LensChallenge` as an onboarding user to get a message to sign.
    *   **Request Payload:**
        ```json
        {
          <!-- Might not need -->
          "app": "0xaC19aa2402b3AC3f9Fe471D4783EC68595432465", // Lens app ID
          "wallet": "<SIGNER_ADDRESS>"
        }
        ```
2.  **Sign Onboarding Message:** Have the user sign the challenge message received.
3.  **Get Onboarding Token:** Call `LensAuthenticate` with the signed message to obtain a temporary token for the onboarding process.
4.  **Create Account Metadata:** Prepare the account metadata according to the [Lens Protocol documentation](https://lens.xyz/docs/protocol/accounts/create#create-account-metadata). This typically includes profile details like name, bio, picture, etc.
5.  **Upload Metadata:** Upload the prepared metadata JSON to a decentralized storage provider like Grove. See [Lens documentation](https://lens.xyz/docs/protocol/accounts/create#upload-account-metadata).
6.  **Create Account Transaction:** Call the `createAccountWithUsername` contract function (or similar, depending on the desired creation method) with the required parameters, including the username and the URI of the uploaded metadata.
7.  **Wait for Transaction:** Monitor the blockchain for the transaction to be confirmed. Refer to [Handling Results documentation](https://lens.xyz/docs/protocol/accounts/create#handle-result).
8.  **Retrieve Account Address:** Once the transaction is confirmed, call the `account` function using the transaction hash (`txHash`) to get the address of the newly created Lens account.
9.  **Switch Account & Get Tokens:** Call `switchAccount` (or a similar mechanism like re-authenticating using the [Login Flow](#login-to-lens-flow) with the *newly created account's address*) to obtain the final authentication tokens for the newly created Lens account.
