<?php

use Behat\Behat\Context\ClosuredContextInterface;
use Behat\Behat\Context\TranslatedContextInterface;
use Behat\Behat\Context\BehatContext;
use Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;

//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//

/**
 * Features context.
 */
class FeatureContext extends MinkContext
{
    private $headers;
    private $jsonData;
    private $verb;
    private $username;
    private $password;
    private $url;
    private $response;

    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     * @param array $parameters context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here
    }

    /**
     * @Given /^I wait sometime$/
     */
    public function iWaitSometime()
    {
        $this->getSession()->wait(2000);
    }

    /**
     * @Given /^I want to call "([^"]*)"$/
     */
    public function iWantToCall($arg1)
    {
        $this->url = $arg1;
    }

    /**
     * @When /^I give set username as "([^"]*)" and password as "([^"]*)"$/
     */
    public function iGiveSetUsernameAsAndPasswordAs($arg1, $arg2)
    {
        $this->username = $arg1;
        $this->password = $arg2;
    }


    /**
     * @When /^I add in json data$/
     */
    public function iAddInJsonData()
    {
        $this->jsonData = '{
	"Request": {
		"satn": "123456",
		"itemCount": "1",
		"cardStatus": "Receive",
		"transDate": "2018-09-06 05:11:00",
		"merchantId": "915051220050178",
        "terminalId": "90157866",
        "cacoId": "05100010",
        "referenceNo": "17098652134"
	},
	"CardInfo": [
    {
        "URN": "77667766"
    }
    ]
}';
    }

    /**
     * @Given /^I set verb as "([^"]*)"$/
     */
    public function iSetVerbAs($arg1)
    {
        $this->verb = $arg1;
    }

    /**
     * @Given /^I create authorization header$/
     */
    public function iCreateAuthorizationHeader()
    {
        //content md5
        $contentMd5 = base64_encode(md5($this->jsonData, true));

        //content type
        $contentType = 'application/json';

        // Set the date timestamp header in UTC format
        $dateNow = new DateTime('now',new DateTimeZone('UTC'));
        $authdate = $dateNow->format('c');

        // Form the string we use as part of the Authorization header
        $stringToHash = $this->verb . "\n" . $contentMd5 ."\n" . $contentType . "\n" . $authdate . "\n";
        $authCode = base64_encode(hash_hmac('sha1', $stringToHash, $this->password));
        $authorization = 'RDN-CRM '.$this->username.':' . $this->password . ':'. $authCode;

        $this->headers = [
            'Content-Type' => 'application/json',
            'Content-Length' => strlen($this->jsonData),
            'Content-MD5' => $contentMd5,
            'Authorization' => $authorization,
            'Date' => $authdate,
        ];
    }

    /**
     * @Given /^I call the api$/
     */
    public function iCallTheApi()
    {
        $client = new GuzzleHttp\Client([
            'base_uri' => $this->getMinkParameter('base_url')
        ]);

        $request_options = [
            'headers' => $this->headers,
            'body' => $this->jsonData,
        ];

        $response = $client->request(
            $this->verb,
            $this->url,
            $request_options
        );

        $this->response = $response->getBody();
    }


    /**
     * @Then /^I should get json response$/
     */
    public function iShouldGetJsonResponse()
    {
        $decodedResponse = json_encode(json_decode($this->response));
        PHPUnit_Framework_Assert::assertNotContains('RDNException', $decodedResponse);
    }

}
