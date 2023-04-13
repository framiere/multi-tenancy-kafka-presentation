package fr.devoxx.demo.safeguard;

import io.conduktor.gateway.interceptor.Interceptor;
import io.conduktor.gateway.interceptor.InterceptorContext;
import io.conduktor.gateway.rebuilder.exception.GatewayIntentionException;
import org.apache.kafka.common.errors.PolicyViolationException;
import org.apache.kafka.common.requests.ProduceRequest;

import java.util.concurrent.CompletionStage;

import static java.util.concurrent.CompletableFuture.completedStage;
import static java.util.concurrent.CompletableFuture.failedFuture;

public class AckAllInterceptor implements Interceptor<ProduceRequest> {
    @Override
    public CompletionStage<ProduceRequest> intercept(ProduceRequest produceRequest, InterceptorContext interceptorContext) {
        if (produceRequest.acks() != -1) {
            return failedFuture(
                    new GatewayIntentionException("Produce request need to ack to all ISR",
                            produceRequest.getErrorResponse(new PolicyViolationException("Acks is invalid. Should be -1"))));
        }
        return completedStage(produceRequest);
    }
}
