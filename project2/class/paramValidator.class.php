<?php
require '../vendor/autoload.php';
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response as Response;
class paramValidator
{
  public function __invoke(Request $request, RequestHandler $handler)
    {
        $validationRules = [
            'fullname' => '/^.+$/',
            'email' => '/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/',
            'content' => '/^.+$/',
        ];


        $body = $request->getParsedBody();

        if ($request->getHeader('content-type') === 'application/json') {
            $body = json_decode($request->getBody(), true);
        }

        if($body === null){
            $request = $request->withAttribute("has_error", true);
            $request = $request->withAttribute("error_message", "no data is given");
            $request = $request->withAttribute("code", 400);
            return $handler->handle($request);
        }

        foreach ($validationRules as $param => $regexPattern) {
            
            if(array_key_exists($param, $body)){
                 if (empty($body[$param]) || !preg_match($regexPattern, $body[$param]) ) {
                            $request = $request->withAttribute("has_error", true);
                            $request = $request->withAttribute("error_message", "invalid $param");
                            $request = $request->withAttribute("code", 400);
                            return $handler->handle($request);                    
                }
            }
        }
        return $handler->handle($request);
    }
}

?>