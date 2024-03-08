//
//  OpenAIFile.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/22/24.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

class OpenAIService {
    
    static let shared = OpenAIService()
    
    private init() {}
    
    private func generateAIRequest(httpMethod: HTTPMethod, message: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        //Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        //Header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secret.key)", forHTTPHeaderField: "Authorization")
        //Body
        //system message being sent to chatgpt before
        let systemMessage = GPTMessage(role: "system", content: "I want you to act as a recipe generator. I will provide you with a list of ingredients and you will suggest a unique recipe that can be created with them. You are also are a verifer for the recipies, if the ingredients are not edible, involves cannibalism towards humans, and harmful for human consumption, or involve any body parts in the ingredients, for example, human body parts, hands, ears, toes, fingers, blood, flesh, and electronics, then ALWAYS return the word \"ERROR\". Number the instructions and be thorough with explaining them with detailes and measurements. I want the recipes to be a maximum of 20 minutes, nothing more, and I want you to give me one detailed recipe. Keep in mind that I have majority of common seasonings and sauces that are within an average household. If the ingredients are entered in spanish translate the instructions for the recipe in spanish. If the ingredients are sent in arabic translate the instructions for the recipe in arabic. If ingredients are in english respond in english.")
        let userMessage = GPTMessage(role: "user", content: message)
        let ingredients = GPTFunctionProperty(type: "string", description: "The available ingredients are \(message). Give me the ingredients seperated by a whitespace, NO commas.")
        let recipe = GPTFunctionProperty(type: "string", description: "The recommended recipe to make.")
        let description = GPTFunctionProperty(type: "string", description: "Here is a short detailed description of this recipe. It should be 15 words or less and not be the same as the recipe name.")
        let instructions = GPTFunctionProperty(type: "string", description: "Here are detailed instructions for this recipe that are numbered for each step. Each step should start on a new line and have a title for each step.")
        let timeToCook = GPTFunctionProperty(type: "string", description: "Here is how long it takes to cook this recipe in minutes and give the number only. For example: 20")

        let params: [String: GPTFunctionProperty] = [
            "ingredients": ingredients,
            "instructions": instructions,
            "recipe": recipe,
            "timeToCook": timeToCook,
            "description": description
        ]
        
        let functionParam = GPTFunctionParam(type: "object", properties: params, required: ["ingredients", "recipe", "instructions", "timeToCook", "description"])
        let function = GPTFunction(name: "get_recipe", description: "Get the recipe with the given ingredients", parameters: functionParam)
        let payload = GPTChatPayload(model: "gpt-3.5-turbo-0613", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
        return urlRequest
    }
    
    func sendPromptToChatGPT(message: String) async throws -> (RecipeResponse) {
        let urlRequest = try generateAIRequest(httpMethod: .post, message: message)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let gptResponse = try JSONDecoder().decode(GPTResponse.self, from: data)
        let args = gptResponse.choices[0].message.functionCall.arguments
        guard let argData = args.data(using: .utf8) else {
            throw URLError(.badURL)
        }
        let response = try JSONDecoder().decode(RecipeResponse.self, from: argData)
        
        return (response)
        
    }
}

//Encoding

struct GPTChatPayload: Encodable {
    let model: String
    let messages: [GPTMessage]
    let functions: [GPTFunction]
}
struct GPTMessage: Encodable {
    let role: String
    let content: String
}

struct GPTFunction: Encodable {
    let name: String
    let description: String
    let parameters: GPTFunctionParam
}

struct GPTFunctionParam: Encodable {
    let type: String
    let properties: [String: GPTFunctionProperty]?
    let required: [String]?
}

struct GPTFunctionProperty: Encodable {
    let type: String
    let description: String
}

//Decoding

struct GPTResponse: Decodable {
    let choices: [GPTCompletion]
}

struct GPTCompletion: Decodable {
    let message: GPTResponseMessage
}

struct GPTResponseMessage: Decodable {
    let functionCall: GPTFunctionCall
    
    enum CodingKeys: String, CodingKey {
        case functionCall = "function_call"
    }
}

struct GPTFunctionCall: Decodable {
    let name: String
    let arguments: String
}

struct RecipeResponse: Decodable {
    let ingredients: String
    let recipe: String
    let instructions: String
    let timeToCook: String
    let description: String
}
